# Properties
$extList = New-Object System.Collections.ArrayList
$createdFolderPaths = New-Object System.Collections.ArrayList

# Take path as input
$targetDir = Read-Host "Enter the path of the directory you want to sort"
Write-Host "Sorting files in $targetDir"

# Get all files in the directory, only files
$files = Get-ChildItem -Path $targetDir | Where-Object { 
    -not $_.PSIsContainer -and $_.Extension -notlike "*ps*" 
}

Write-Host "Found $($files.Count) files"
foreach ($file in $files) {
    Write-Host "Processing file: $($file.Name)"
}

#Create folder for each extension
for ($i = 0; $i -lt $files.Count; $i++) 
{
    # Force extension to lowercase to handle case insensitivity
    $ext = $files[$i].Extension.Substring(1).ToLower()

    # Check extList does not contain ext and ext does not contain "ps"
    if((-not $extList.Contains($ext)) -and ($ext -notlike "*ps*"))
    {
        $folderPath = "$targetDir\$ext"

        # Create the directory only if it doesn't exist
        if (-not (Test-Path -Path $folderPath -PathType Container)) {
            New-Item -ItemType Directory -Path $folderPath
            $createdFolderPaths.Add($folderPath)
        } elseif ((Test-Path -Path $folderPath -PathType Container) -and ($createdFolderPaths -notcontains $folderPath)) {
            $createdFolderPaths.Add($folderPath)
        }

        # Add the extension to extList to prevent duplicate creation
        $extList.Add($ext)
    }
}


foreach ($path in $createdFolderPaths) {
    Write-Host "Creating folder for $path"
}