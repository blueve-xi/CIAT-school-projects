# Desktop Organizer Script - Simple & Safe
# Run in PowerShell (no admin rights needed)

$Desktop = [Environment]::GetFolderPath("Desktop")
Write-Host "Scanning Desktop: $Desktop" -ForegroundColor Cyan

# Define categories and their extensions
$Categories = @{
    "Images"     = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp", ".tiff")
    "Documents"  = @(".pdf", ".docx", ".doc", ".txt", ".xlsx", ".xls", ".pptx", ".ppt", ".rtf")
    "Videos"     = @(".mp4", ".mov", ".avi", ".mkv", ".wmv", ".flv", ".webm")
    # "Others" will catch everything else
}

# Create category folders if they don't exist
foreach ($folder in $Categories.Keys) {
    $folderPath = Join-Path $Desktop $folder
    if (-not (Test-Path $folderPath)) {
        try {
            New-Item -Path $folderPath -ItemType Directory -Force | Out-Null
            Write-Host "Created folder: $folder" -ForegroundColor Green
        }
        catch {
            Write-Warning "Failed to create folder '$folder': $_"
        }
    }
}

# Also ensure "Others" folder exists
$othersFolder = Join-Path $Desktop "Others"
if (-not (Test-Path $othersFolder)) {
    New-Item -Path $othersFolder -ItemType Directory -Force | Out-Null
    Write-Host "Created folder: Others" -ForegroundColor Green
}

# Get all files (not folders) on the desktop
$Files = Get-ChildItem -Path $Desktop -File -ErrorAction SilentlyContinue

if ($Files.Count -eq 0) {
    Write-Host "No files found on Desktop. Nothing to organize." -ForegroundColor Yellow
    pause
    exit
}

Write-Host "Found $($Files.Count) file(s) to organize..." -ForegroundColor Cyan

# Counter for progress
$movedCount = 0

foreach ($file in $Files) {
    $moved = $false
    $extension = $file.Extension.ToLower()

    # Skip if it's a common system file (optional safety)
    if ($file.Name -in @("desktop.ini", "Thumbs.db")) {
        continue
    }

    foreach ($category in $Categories.Keys) {
        if ($extension -in $Categories[$category]) {
            $targetFolder = Join-Path $Desktop $category
            $destination = Join-Path $targetFolder $file.Name

            try {
                # Avoid name conflicts by adding (1), (2), etc. if needed
                if (Test-Path $destination) {
                    $baseName = [IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $ext = $file.Extension
                    $i = 1
                    do {
                        $newName = "$baseName ($i)$ext"
                        $destination = Join-Path $targetFolder $newName
                        $i++
                    } while (Test-Path $destination)
                }

                Move-Item -Path $file.FullName -Destination $destination -Force
                Write-Host "Moved: $($file.Name) → $category" -ForegroundColor Gray
                $moved = $true
                $movedCount++
                break
            }
            catch {
                Write-Warning "Failed to move $($file.Name): $_"
            }
        }
    }

    # If not matched to any category, move to Others
    if (-not $moved) {
        $destination = Join-Path $othersFolder $file.Name
        try {
            if (Test-Path $destination) {
                $baseName = [IO.Path]::GetFileNameWithoutExtension($file.Name)
                $ext = $file.Extension
                $i = 1
                do {
                    $newName = "$baseName ($i)$ext"
                    $destination = Join-Path $othersFolder $newName
                    $i++
                } while (Test-Path $destination)
            }

            Move-Item -Path $file.FullName -Destination $destination -Force
            Write-Host "Moved: $($file.Name) → Others" -ForegroundColor Gray
            $movedCount++
        }
        catch {
            Write-Warning "Failed to move $($file.Name) to Others: $_"
        }
    }
}

# Final summary
Write-Host "`nOrganization Complete!" -ForegroundColor Green
Write-Host "Successfully moved $movedCount file(s) into categorized folders." -ForegroundColor White

# Optional: Pause so user can see the result
Write-Host "`nPress any key to exit..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
