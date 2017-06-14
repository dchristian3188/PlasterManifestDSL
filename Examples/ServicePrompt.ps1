PlasterManifest {
    Metadata {
        Title = "Loops to Generate A Manifest"
        TemplateName = 'ServicePrompt'
        Author = "David Christian"
        Description = "Plaster template to create an advanced function with tests"
        TemplateVersion = '0.0.1'
    }
    Parameters {
        MultiChoice -Name BServices -Prompt "Services that start with the letter B" {
            $services = Get-Service -Name B* |
                Sort-Object -Property Name
            ForEach($service in $services)
            {
                Choice -Label $service.Name -Help "Does something with $($service.DisplayName)"
            }
        }
    }
}