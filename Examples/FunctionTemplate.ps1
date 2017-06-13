ipmo $PSScriptRoot\..\PlasterDSL.psd1 -Force -Verbose
PlasterManifest {
    Metadata {
        Title = "DC Custom Function Template"
        TemplateName = 'CustomFunction'
        Author = "David Christian"
        Description = "Plaster template to create an advanced function with tests"
        TemplateVersion = '0.0.1'
        ID = 'cbbb914c-6601-4530-92e5-91924660c6ce'
    }
    Parameters {
        Text -Name "FunctionName" -Prompt "Name of your function"
        SingleChoice -Name "Help" -Prompt "Include Comment based Help?" -Default 0 {
            Choice -Label "Yes" -Help "Adds Comment Based" -Value "Yes"
            Choice -Label "No" -Help "Does not add comment based help" -Value "no"
        }
    }
    Content {
        Message "Including Helper Paramaters" {
            $PLASTER_PARAM_Help -eq "Yes"
        }
        File -Source "functionTemplate.ps1" -Destination '${PLASTER_PARAM_FunctionName}.ps1' -Condition {
            $PLASTER_PARAM_Pester -eq $true
        }
        TemplateFile -Source 'testsTemplate.ps1' -Destination '${PLASTER_PARAM_FunctionName}.tests.ps1'
    }
} | Export-PlasterManifest -Destination C:\temp\plasterManifest.xml -Verbose -PassThru | % {Code $psitem.fullname}
