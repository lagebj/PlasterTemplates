[cmdletbinding()]
param()

foreach ($folder in @(
    'classes',
    'scripts\private',
    'scripts\public')) {
        $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
        if (Test-Path -Path $root) {
            $files = Get-ChildItem -Path $root -Filter *.ps1 -Recurse
            $files | where-Object {
                $_.name -NotLike '*.Tests.ps1'
            } | ForEach-Object {
                . $_.FullName
            }
        }
    }

Export-ModuleMember -function (Get-ChildItem -Path "$PSScriptRoot\scripts\public\*.ps1").basename