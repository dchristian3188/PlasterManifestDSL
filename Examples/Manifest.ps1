PlasterManifest {
    Metadata {
        TemplateName = "ModuleTemplate"
        Title = "DC Custom Module Template"
        Description = "Plaster template to create a module"
        Author = "David Christian"
    }
    Parameters {
        UserFullNameParameter "ModuleAuthor" "Author"
        TextParameter "ModuleName" "Name of your module"
        TextParameter "ModuleVersion" "Version Number" -Default '0.0.0.1'
        TextParameter "ModuleDesc" "Brief Description of your module"
        MultiChoiceParameter "FunctionFolders" "Please select folders to include" -Default "0,1,2" {
            Choice -Label 'Public' -Help 'Adds a public folder to module root' -Value 'Public'
            Choice -Label 'Internal' -Help 'Adds a internal folder to module root' -Value "Internal"
            Choice -Label 'Classes' -Help "Adds a classes folder to module root" -Value 'Classes'
            Choice -Label 'Binaries' -Help 'Adds a binaries folder to module root' -Value 'Binaries'
            Choice -Label 'Data' -Help 'Does not add a pester folder' -Value 'Data'
        }
    }
}