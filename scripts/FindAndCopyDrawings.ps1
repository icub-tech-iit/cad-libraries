Add-Type -AssemblyName System.Windows.Forms

# ----------------------------------------
# 1. Setup Base Directories
# ----------------------------------------

# Get the directory where the script is located.
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
}

# The default base is the parent of the script's directory.
$defaultBase = Split-Path -Parent $scriptDir
Write-Host "Default base directory: $defaultBase"

# ----------------------------------------
# 2. Ask the User to Select Folders/Files
# ----------------------------------------

# Ask user to select the folder that contains the source files (.prt.1 and .asm.1).
$folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
$folderDialog.Description = "Select Folder Containing Source Files (.prt.1 and .asm.1)"
$null = $folderDialog.ShowDialog()
$sourceFolder = $folderDialog.SelectedPath
if (-not $sourceFolder) {
    Write-Host "No folder selected. Exiting..."
    exit
}

# Ask user to select the search path file (.pro).
$fileDialog = New-Object System.Windows.Forms.OpenFileDialog
$fileDialog.Filter = "Pro Files (*.pro)|*.pro"
$fileDialog.Title = "Select Search Path File (.pro)"
$null = $fileDialog.ShowDialog()
$searchPathFile = $fileDialog.FileName
if (-not $searchPathFile) {
    Write-Host "No search path file selected. Exiting..."
    exit
}

# ----------------------------------------
# 3. Read the .pro File and Extract Search Paths
# ----------------------------------------

$searchPaths = @()
Get-Content $searchPathFile | ForEach-Object {
    $line = $_.Trim()
    # Skip empty lines and comment lines (starting with '!')
    if (-not [string]::IsNullOrWhiteSpace($line) -and -not $line.StartsWith('!')) {
        if ($line -match '^search_path\s+"(.+)"') {
            $relativePath = $matches[1].Trim()
            if ($relativePath) {
                $searchPaths += $relativePath
            }
        }
    }
}

# ----------------------------------------
# 4. Build Absolute Search Paths
# ----------------------------------------
# Rules:
# - If the search path starts with ".\..\", then use the parent of the default base.
# - If it starts with ".\", then use the default base.
$absSearchPaths = @()
foreach ($relativePath in $searchPaths) {
    try {
        if ($relativePath -like ".\..\*") {
            # Remove the leading ".\..\" (4 characters)
            $remainder = $relativePath.Substring(4)
            # New base is the parent of the default base.
            $newBase = Split-Path -Parent $defaultBase
        }
        elseif ($relativePath -like ".\*") {
            # Remove the leading ".\" (2 characters)
            $remainder = $relativePath.Substring(2)
            $newBase = $defaultBase
        }
        else {
            $remainder = $relativePath
            $newBase = $defaultBase
        }
        $combinedPath = Join-Path $newBase $remainder
        $normalizedPath = [IO.Path]::GetFullPath($combinedPath)
        if (Test-Path $normalizedPath) {
            $absSearchPaths += $normalizedPath
        }
        else {
            Write-Warning "Path does not exist and will be skipped: $normalizedPath"
        }
    }
    catch {
        Write-Warning "Error processing path: $relativePath. Exception: $_"
    }
}

Write-Host "Resolved Search Paths:"
$absSearchPaths | ForEach-Object { Write-Host "  $_" }

# ----------------------------------------
# 5. Process Each Source File (.prt.1 and .asm.1)
# ----------------------------------------
# Get all files in the source folder that match *.prt.1 or *.asm.1.
$sourceFiles = Get-ChildItem -Path $sourceFolder | Where-Object { $_.Name -match '^(.*)\.(prt|asm)\.1$' }
Write-Host "Number of source files found: " ($sourceFiles | Measure-Object).Count

$foundDrawings = @()
$notFoundDrawings = @()
$multipleDrawings = @()

foreach ($file in $sourceFiles) {
    if ($file.Name -match '^(.*)\.(prt|asm)\.1$') {
        $baseName = $matches[1]
        # The drawing file to search ends with ".drw.1"
        $drawingName = "$baseName.drw.1"
        $foundPaths = @()
        
        # Look for the drawing file in all absolute search paths.
        foreach ($searchDir in $absSearchPaths) {
            $potentialDrawing = Join-Path $searchDir $drawingName
            if (Test-Path $potentialDrawing) {
                $foundPaths += $potentialDrawing
            }
        }
        
        if ($foundPaths.Count -eq 0) {
            $notFoundDrawings += $file.Name
        }
        elseif ($foundPaths.Count -gt 1) {
            $multipleDrawings += [PSCustomObject]@{
                file = $file.Name
                drawings = $foundPaths
            }
        }
        else {
            # Exactly one drawing found: copy it to the source folder.
            $sourceFile = $foundPaths[0]
            $destinationFile = Join-Path $sourceFolder $drawingName
            Copy-Item -Path $sourceFile -Destination $destinationFile -Force
            $foundDrawings += [PSCustomObject]@{
                file = $file.Name
                drawing = $destinationFile
            }
        }
    }
}

# ----------------------------------------
# 6. Generate and Save Report
# ----------------------------------------
# Save the report in the source folder with the name "DRAWINGS COPY REPORT.md".
$reportFile = Join-Path $sourceFolder "DRAWINGS COPY REPORT.md"
$reportContent = @()
$reportContent += "Drawings Report"
$reportContent += "==============="
$reportContent += ""

$reportContent += "Drawings Not Found:"
$reportContent += "-------------------"
foreach ($item in $notFoundDrawings) {
    $reportContent += "$item -> Not Found"
}
$reportContent += ""

$reportContent += "Multiple Drawings Found:"
$reportContent += "------------------------"
foreach ($item in $multipleDrawings) {
    $reportContent += "$($item.file) -> Multiple Found:"
    foreach ($drawing in $item.drawings) {
        $reportContent += "    $drawing"
    }
}
$reportContent += ""

$reportContent += "Found Drawings:"
$reportContent += "---------------"
foreach ($item in $foundDrawings) {
    $reportContent += "$($item.file) -> $($item.drawing)"
}
$reportContent += ""

$reportContent | Out-File -FilePath $reportFile -Encoding UTF8
Write-Host "Report saved at: $reportFile"
Write-Host "Drawing files copied to the source folder."
