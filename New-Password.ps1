function New-Password {

    <#
    .SYNOPSIS
        This function will create a new password with random characters.
    .DESCRIPTION
        This function will create a new password with random characters.
        Accepts input for desired total number of characters and the minimum number of special characters.
    .EXAMPLE
        PS> New-Password
    .EXAMPLE
        PS> New-Password -NumberOfCharacters 24 -MinimumSpecial 10
    .PARAMETER NumberOfCharacters
        The total number of characters of the result.
    .PARAMETER MinimumSpecial
        The minimum number of special characters included in the result.
    #>

    [CmdletBinding()]

    param (

        [Parameter(Mandatory=$false)]
        [int]$NumberOfCharacters=12,
        [Parameter(Mandatory=$false)]
        [int]$MinimumSpecial=2
        
    )

    begin {

        Add-Type -AssemblyName System.Web

    }
    process {

        [System.Web.Security.Membership]::GeneratePassword($NumberOfCharacters,$MinimumSpecial)

    }

}
