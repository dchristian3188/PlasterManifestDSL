InModuleScope PlasterManifestDSL {
    Describe 'New-Condition' {
        It 'Replaces single quotes with double' {
            $result = " condition='`$val -eq `"yes`"'"
            New-Condition -Condition {$val -eq 'yes'} | Should be $result
        }
    }
}
