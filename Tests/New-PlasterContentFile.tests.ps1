Import-Module -Name $(Join-Path -Path $PSScriptRoot -ChildPath 'ShouldBeErrorId.ps1')
Describe 'New-PlasterContentFile'{
    BeforeAll {
        $validTestCases = @(
            @{
                Description = 'Makes directories'
                Results     = @"
<file source=''
    destination='NewDir'
/>
"@
                SB          = {New-PlasterContentFile -Source '' -Destination 'NewDir'}
            },
            @{
                Description = 'Creates files from a source'
                Results     =  @"
<file source='SoureFile.ps1'
    destination='NewSourceName.ps1'
/>
"@
                SB          = {New-PlasterContentFile -Source 'SoureFile.ps1' -Destination 'NewSourceName.ps1'}
            }
        )

        $failureCases = @(
            @{
                Description = "Requires a parameter"
                SB          = {New-PlasterContentFile -Source '' -Destination ''}
                ErrorID       = 'ParameterArgumentValidationErrorEmptyStringNotAllowed,New-PlasterContentFile'
            }
        )
    }
    It 'Valid Test Case: <Description>' -TestCases $validTestCases {
        Param ( $Description, $Results, $SB)
        $SB.Invoke() | Should Be $Results
    }

    It 'Failure Test Case: <Description>' -TestCases $failureCases {
        Param ( $Description, $SB, $ErrorID)
        $SB | ShouldBeErrorId $ErrorID
    }
}