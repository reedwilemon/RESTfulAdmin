function Send-SmsMessage {
    
    <#
        .SYNOPSIS
            This function will send a text message to a mobile phone.
        .DESCRIPTION
            This function will send an email to a mobile phone that appears as a text message. It relies on SMS-to-email gateways provided by cell phone carriers.
        .EXAMPLE
            PS> Send-SmsMessage -FromAddress name@example.com -MobileNumber 323-555-1234 -SMSBody "You have been notified." -Carrier Verizon
        .PARAMETER FromAddress
            The email address to put in the From field.
        .PARAMETER MobileNumber
            The destination mobile number. Validation is performed to remove non-digits.
        .PARAMETER Carrier
            The mobile carrier of the destination. Must be one of set "AT&T","Sprint","StraightTalk","TMobile","Verizon".
        .PARAMETER SmsBody
            Body of the text message. Must be under 160 characters, but may be limited more by carrier.
        .PARAMETER SmtpServer
            SMTP server used to send the message.
        .PARAMETER SmtpPort
            SMTP port used to send the message to SMTP server. Default value is 25.
    #>

    [CmdletBinding()]
    param (
    
        [Parameter(Mandatory=$True)]
        [string]$FromAddress,
        [Parameter(Mandatory=$True)]
        [string]$MobileNumber,
        [Parameter(Mandatory=$True)]
        [ValidateSet("AT&T","Sprint","StraightTalk","TMobile","Verizon")]
        [string]$Carrier,
        [Parameter(Mandatory=$false)]
        [ValidateLength(1,160)]
        [string]$SmsBody = "This is a test.",
        [Parameter(Mandatory=$True)]
        [string]$SmtpServer,
        [Parameter(Mandatory=$false)]
        [int]$SmtpPort = 25
        
    )
    
    process {
    
        $MobileNumber = $MobileNumber -replace '\D+',''
        $CarrierDomain = switch ($Carrier) {
            
            "AT&T" {"txt.att.net"}
            "Sprint" {"messaging.sprintpcs.com"}
            "StraightTalk" {"vtext.com"}
            "TMobile" {"tmomail.net"}
            "Verizon" {"vtext.com"}
            
        }
        $SmsParams = @{
    
            To = "$MobileNumber@$CarrierDomain"
            Subject = "Computer: $env:computername"
            Body = $SMSBody
            From = $FromAddress
            SmtpServer = $SmtpServer
            Port = $SmtpPort
            BodyAsHtml = $false
            #-UseSsl
    
        }
    
        Send-MailMessage @SmsParams
    
    }

}
