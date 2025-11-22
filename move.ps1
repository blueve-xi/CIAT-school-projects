# PowerShell Script: System Information Backup

# a. Display the current date and time
Write-Host "Script started at: " -ForegroundColor Green
Get-Date
Write-Host ""  # Empty line for better readability

# b. Retrieve a list of running processes and save it to a file
$ProcessFile = "RunningProcesses_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').txt"
Write-Host "Retrieving list of running processes..." -ForegroundColor Yellow
Get-Process | Select-Object Id, Name, CPU, WorkingSet, StartTime, Path | 
    Sort-Object CPU -Descending | 
    Format-Table -AutoSize | 
    Out-File -FilePath $ProcessFile -Encoding UTF8

Write-Host "Process list saved to: $ProcessFile" -ForegroundColor Cyan
Write-Host ""

# c. Create a new directory named "Backup" in the current location
$BackupPath = ".\Backup"
if (-not (Test-Path -Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    Write-Host "Directory 'Backup' created successfully." -ForegroundColor Green
} else {
    Write-Host "Directory 'Backup' already exists." -ForegroundColor Gray
}

# d. Move the file created in step b to the "Backup" directory
$Destination = "$BackupPath\$ProcessFile"
Move-Item -Path $ProcessFile -Destination $Destination -Force
Write-Host "File moved to: $Destination" -ForegroundColor Cyan

# e. Display completion message
Write-Host ""
Write-Host "===========================================" -ForegroundColor Magenta
Write-Host "     Script completed successfully!     " -ForegroundColor Magenta
Write-Host "===========================================" -ForegroundColor Magenta
Write-Host "Backup location: $(Resolve-Path $BackupPath)" -ForegroundColor White
Write-Host "Current date and time: $(Get-Date)" -ForegroundColor White
