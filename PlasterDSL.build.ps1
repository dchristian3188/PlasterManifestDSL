
# Synopsis: Creates the output directory
task "Create Output" -If(-not(Test-Path -Path 'Output')) {
    New-Item -Path Output -ItemType Directory
}

# Synopsis: Cleans the output directory
task Clean {
    Remove-Item -Path Output\* -Recurse -Force
}

# Synopsis: Does all the things
task . "Create Output", Clean