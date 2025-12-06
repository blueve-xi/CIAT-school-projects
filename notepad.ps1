# 1. Open Notepad and display a message
Write-Host "Opening Notepad..." -ForegroundColor Green

# Start Notepad and capture the process object so we can wait for it
$notepad = Start-Process notepad.exe -PassThru

Write-Host "Notepad is now open. Please leave it open." -ForegroundColor Yellow

# 2. Wait for Notepad to close
Write-Host "Waiting for you to close Notepad..." -ForegroundColor Cyan
Write-Host "please close the Notepad window to continue the script." -ForegroundColor White

$notepad.WaitForExit()

Write-Host "Notepad has been closed. Continuing..." -ForegroundColor Green

# 3. Create "Lab Files" folder on the Desktop and a file inside it
$desktop = [Environment]::GetFolderPath("Desktop")
$labFolder = Join-Path $desktop "Lab Files"

New-Item -Path $labFolder -ItemType Directory -Force | Out-Null
Write-Host "Created folder: $labFolder" -ForegroundColor Green

$sampleFile = Join-Path $labFolder "SampleFile.txt"
New-Item -Path $sampleFile -ItemType File -Force | Out-Null
Write-Host "Created file: $sampleFile" -ForegroundColor Green

# 4. Open SampleFile.txt in Notepad for editing
Write-Host "Opening SampleFile.txt in Notepad for editing..." -ForegroundColor Green
Write-Host ">>> Please type a short message then SAVE and close Notepad." -ForegroundColor Yellow

Start-Process notepad.exe -ArgumentList $sampleFile -PassThru | Wait-Process

Write-Host "You have closed the file. Proceeding..." -ForegroundColor Green

# 5. Read and display the content of SampleFile.txt
Write-Host "`nContent of SampleFile.txt:" -ForegroundColor Magenta
Get-Content $sampleFile | Out-Host
Write-Host ""  # blank line

# 6. Create Backup folder, copy the file, then delete the original
$backupFolder = Join-Path $labFolder "Backup"
New-Item -Path $backupFolder -ItemType Directory -Force | Out-Null
Write-Host "Created Backup folder: $backupFolder" -ForegroundColor Green

$backupFile = Join-Path $backupFolder "SampleFile.txt"
Copy-Item -Path $sampleFile -Destination $backupFile -Force
Write-Host "Copied SampleFile.txt to Backup folder." -ForegroundColor Green

# Permanently delete the original file
Remove-Item -Path $sampleFile -Force
Write-Host "Original SampleFile.txt has been permanently deleted from the folder." -ForegroundColor Red

# 7. Final confirmation
Write-Host "Lab completed successfully!" -ForegroundColor Cyan
Write-Host "You can find your saved text in:" -ForegroundColor White
Write-Host "   $backupFile" -ForegroundColor Yellow
