Describe 'New-PlasterContentBlock'{
    It 'Executes a script block' {
        $sb = {Write-Output -InputObject "Test"}
        $result = @"
<content>
Test
</content>
"@
        New-PlasterContentBlock -ScriptBlock $sb | Should Be $result
    }
}
