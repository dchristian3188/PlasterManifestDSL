Function New-PlasterParameterUserEmail
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $Name,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]
        $Prompt,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 2
        )]
        [string]
        $Default, 

        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateSet('Text','Encrypted')]
        [string]
        $Store
    )

    New-PlasterParameterBaseText -TextType 'user-email' @PSBoundParameters
}

New-Alias -Name UserEmail -Value New-PlasterParameterUserEmail