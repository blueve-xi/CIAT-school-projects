$response = Invoke-RestMethod -Uri "https://zenquotes.io/api/random"

Write-Host "Quote: $($response[0].q) `n$($response[0].a)"

Import-Module BurntToast

function Get-Quote {
    try {
        $response = Invoke-RestMethod -Uri "https://zenquotes.io/api/random"
        return "Quote: $($response[0].q) `n$($response[0].a)"
    }
    catch {
        return "not avalible"
    }
}

$quoteText = Get-Quote

New-BurnToastNotification -Text "Daily motivational Quote", $quoteText