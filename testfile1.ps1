# FileAnalyzer.ps1
# Simple text file analyzer with line, word, and character count

function AnalyzeFileContent {
    param (
        [string]$Path
    )

    # Check if file exists
    if (-not (Test-Path $Path)) {
        Write-Host "Error: File not found!" -ForegroundColor Red
        return $null
    }

    # Read all lines
    $lines = Get-Content -Path $Path
    $lineCount = $lines.Count

    # Join all lines to count characters and words
    $fullText = $lines -join "`n"
    $charCount = $fullText.Length

    # Count words by splitting on whitespace
    $words = $fullText -split '\s+' | Where-Object { $_.Length -gt 0 }
    $wordCount = $words.Count

    # Return results as an object
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

# ——— Main Script Starts Here ———

Write-Host "Text File Analyzer" -ForegroundColor Green
Write-Host "Enter the full path to a text file below.`n"

$path = Read-Host "File Path"

# Call the analysis function
$result = AnalyzeFileContent -Path $path

# If analysis succeeded, generate report
if ($result) {
    GenerateReport -Data $result -FilePath $path
    Write-Host "`nAnalysis completed successfully!" -ForegroundColor Green
} else {
    Write-Host "`nAnalysis failed. Please check the file path and try again." -ForegroundColor Red
}

Read-Host "`nPress Enter to exit"
