function Send-ConsoleBeep {

    <#
        .SYNOPSIS
            This function will play a beep sound from the console.
        .DESCRIPTION
            This function will play a beep sound from the console. By default, the beep plays at a frequency of 800 hertz for a duration of 200 milliseconds.
        .EXAMPLE
            PS> Send-ConsoleBeep
        .EXAMPLE
            PS> Send-ConsoleBeep -Pitch 440 -Duration 5000
        .PARAMETER Pitch
            Pitch of beep in hertz. Default value is 800.
        .PARAMETER Duration
            Duration of beep in milliseconds. Default value is 200.
    #>

    [CmdletBinding()]
    param (
    
        [Parameter(Mandatory=$false)]
        [ValidateRange(150,10000)]
        [int]$Pitch = 800,
        [Parameter(Mandatory=$false)]
        [int]$Duration = 200

    )

    [console]::beep($Pitch,$Duration)

}
