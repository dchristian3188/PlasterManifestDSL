Import-Module -Name $PSScriptRoot\..\PlasterDSL.psd1 -Force -Verbose
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
            Choice -Label "Yes" -Help "Adds Comment Based"
            Choice -Label "No" -Help "Does not add comment based help"
        }
        
        SingleChoice -Name "PipelineSupport" -Prompt "Include Begin Process End blocks?" -Default 0 {
            Choice -Label "Yes" -Help "Adds begin process and end to function"
            Choice -Label "No" -Help "Does not pipeline support to the function"
        }

        SingleChoice -Name "CmdletBinding" -Prompt "Simple cmdlet binding or Advanced?" -Default 0 {
            Choice -Label "Simple" -Help "Adds a default parameter for computername"
            Choice -Label "Advanced" -Help "Does not include computername parameter"
        }

        SingleChoice -Name 'ComputerName' -Prompt "Add a paramater for computername" -Default 0 {
            Choice -Label "Yes" -Help "Adds a default parameter for computername"
            Choice -Label "No" -Help "Does not include computername parameter"
        }

    }
    Content {
        TemplateFile -Source 'functionTemplate.ps1' -Destination '${PLASTER_PARAM_FunctionName}.ps1'
        TemplateFile -Source 'testsTemplate.ps1' -Destination '${PLASTER_PARAM_FunctionName}.tests.ps1'
    }
} | Export-PlasterManifest -Destination C:\temp\plasterManifest.xml -Verbose -PassThru | % {Code $psitem.fullname}
