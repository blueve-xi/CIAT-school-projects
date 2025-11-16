$name = Read-Host = "enter name"
Write-Host "Hello, $name!"

$num = Read-Host = "enter a number, to start countdown"
$start = [int]$num
for ($i = $start; $i -ge 1; $i--) {
    Write-Host $i
    Start-Sleep -Seconds 1
}