# Take path as input
$targetDir = Read-Host "Enter the path of the directory you want to sort"
Write-Host "Sorting files in $targetDir"

# Get all files in the directory
$files = Get-ChildItem -Path $targetDir
Write-Host "Found $($files.Count) files"

# Get a list of the extensions
$list = New-Object System.Collections.ArrayList

