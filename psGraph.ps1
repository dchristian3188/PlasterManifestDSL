graph CommandFlow {
    $moduleRoot = $PSScriptRoot
    $scripts = @{}
    Get-ChildItem $moduleRoot -Filter *.ps1 -Recurse -File |
        Where-Object -FilterScript {$PSItem.FullName -notmatch 'Examples|tests'} |
        ForEach-Object -Process {
            $scripts[$PSItem.BaseName] = $PSItem.FullName
    }

    $scriptNames = $scripts.GetEnumerator()  | Select-Object -ExpandProperty Key
    ForEach ($script in $scriptNames)
    {

        node $script
        $contents = Get-Content -Path $scripts[$script] -ErrorAction Stop
        $errors = $null
        $commands = ([System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors) |
                Where-Object -FilterScript {$PSItem.Type -eq 'Command'}).Content
        ForEach ($command in $commands)
        {
            If ($scripts[$command])
            {
               Edge  $script -To $command
            }
        }
    }
} | Export-PSGraph -ShowGraph