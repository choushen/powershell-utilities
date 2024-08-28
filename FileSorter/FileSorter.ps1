# Take path as input
$targetDir = Read-Host "Enter the path of the directory you want to sort"
Write-Host "Sorting files in $targetDir"

# Get all files in the directory
$files = Get-ChildItem -Path $targetDir
Write-Host "Found $($files.Count) files"

# Get a list of the extensions
$list = New-Object System.Collections.ArrayList

foreach($file in $files)
{
    Write-Host "Processing $file"
    $ext = $file.Extension  
    # Check if folder exists in dir
    if(-not (Test-Path "$targetDir\$ext"))
    {
        Write-Host "Creating folder $ext"
        New-Item -Path "$targetDir\$ext" -ItemType Directory
    }

}