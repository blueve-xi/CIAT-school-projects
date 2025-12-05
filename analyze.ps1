# FileAnalyzer.ps1
function AnalyzeFileContent {
    param (
        [string]$Path
    )

    # Check if file exists
    if (-not (Test-Path $Path)) {
        Write-Host "Error: File not found!" -ForegroundColor Red
        return $null
    }

    # checking lines
    $lines = Get-Content -Path $Path
    $lineCount = $lines.Count

    # checking characters and words
    $fullText = $lines -join "`n"
    $charCount = $fullText.Length

    # Cecking word count
    $words = $fullText -split '\s+' | Where-Object { $_.Length -gt 0 }
    $wordCount = $words.Count

    # Return results
    return [PSCustomObject]@{
        Lines      = $lineCount
        Words      = $wordCount
        Characters = $charCount
    }
}

function GenerateReport {
    param (
        [PSCustomObject]$Data,
        [string]$FilePath
    )

    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "       ANALYSIS REPORT" -ForegroundColor Cyan
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "File: $FilePath" -ForegroundColor White
    Write-Host ""
    Write-Host "Number of Lines     : $($Data.Lines)" -ForegroundColor Yellow
    Write-Host "Number of Words     : $($Data.Words)" -ForegroundColor Green
    Write-Host "Number of Characters: $($Data.Characters)" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Report generated at: $(Get-Date)" -ForegroundColor Gray
    Write-Host "======================================" -ForegroundColor Cyan
}

Write-Host "Text File Analyzer" -ForegroundColor Green
Write-Host "Enter the full path to a text file below.`n"

$path = Read-Host "File Path"

$result = AnalyzeFileContent -Path $path

if ($result) {
    GenerateReport -Data $result -FilePath $path
    Write-Host "`nAnalysis completed successfully!" -ForegroundColor Green
} else {
    Write-Host "`nAnalysis failed. Please check the file path and try again." -ForegroundColor Red
}

Read-Host "`nPress Enter to exit"
