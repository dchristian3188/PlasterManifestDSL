function ShouldBeErrorId
{
    param([Parameter(ValueFromPipeline, Mandatory)]
        [ScriptBlock]
        $sb,

        [Parameter(Mandatory, Position=0)]
        [string]
        $FullyQualifiedErrorId)

        try
        {
            & $sb | Out-Null
            Throw "No Exception!"
        }
        catch
        {
            $_.FullyQualifiedErrorId | Should Be $FullyQualifiedErrorId | Out-Null
            # Write the exception to output that allow us to check later other properies of the exception
            Write-Output $_
        }
}