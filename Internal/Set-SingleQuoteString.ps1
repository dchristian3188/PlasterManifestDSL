Function Set-SingleQuoteString
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]
        $InputString
    )

    $tokens = $null
    $errors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseInput($InputString,[ref]$tokens,[ref]$errors)
    $singleQuotes = $ast.FindAll({$args[0] -is [System.Management.Automation.Language.StringConstantExpressionAst]},$true)
    foreach($singleQuote in $singleQuotes)
    {
        $oldValue = $singleQuote.Extent.Text
        $newValue = '"{0}"' -f $singleQuote.Value
        $InputString = $InputString.ToString().Replace($oldValue,$newValue)
    }

    Write-Output $InputString

}