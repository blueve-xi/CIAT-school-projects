# a. Display date and time
Write-Host "Script started at: " -ForegroundColor Green
Get-Date
Write-Host ""

$ProcessFile = "RunningProcesses_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').txt"
Write-Host "Retrieving list of running processes..." -ForegroundColor Yellow
Get-Process | Select-Object Id, Name, CPU, WorkingSet, StartTime, Path | 
    Sort-Object CPU -Descending | 
    Format-Table -AutoSize | 
    Out-File -FilePath $ProcessFile -Encoding UTF8

Write-Host "Process list saved to: $ProcessFile" -ForegroundColor Cyan
Write-Host ""

# c. Create a dir name backup
$BackupPath = ".\Backup"
if (-not (Test-Path -Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    Write-Host "Directory 'Backup' created successfully." -ForegroundColor Green
} else {
    Write-Host "Directory 'Backup' already exists." -ForegroundColor Gray
}

# d. Move the file to Backup folder
$Destination = "$BackupPath\$Notepadtest"
Move-Item -Path "$env:USERPROFILE\Desktop\*" -Destination $Destination -Force
Write-Host "File moved to: $Destination" -ForegroundColor Cyan

Write-Host ""
Write-Host "===========================================" -ForegroundColor Magenta
Write-Host "     Script completed successfully!     " -ForegroundColor Magenta
Write-Host "===========================================" -ForegroundColor Magenta
Write-Host "Backup location: $(Resolve-Path $BackupPath)" -ForegroundColor White
Write-Host "Current date and time: $(Get-Date)" -ForegroundColor White
