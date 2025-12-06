# greet the user by name
function GreetUser {
    param (
        [string]$Name
    )
    Write-Host "Hello, $Name! Welcome to PowerShell!" -ForegroundColor Cyan
}

# calculate the sum of two numbers
function GetSum {
    param (
        [int]$Num1,
        [int]$Num2
    )
    return $Num1 + $Num2
}

# check if a number is even or odd
function IsEven {
    param (
        [int]$Number
    )
    if ($Number % 2 -eq 0) {
        return "Even"
    } else {
        return "Odd"
    }
}

Clear-Host
Write-Host "=== PowerShell Functions Demo ===" -ForegroundColor Green
Write-Host ""

# Ask for name and greet
$name = Read-Host "Please enter your name"
GreetUser -Name $name

Write-Host ""

# Ask for two numbers and show their sum
Write-Host "Now let's add two numbers!" -ForegroundColor Yellow
$first  = Read-Host "Enter the first number"
$second = Read-Host "Enter the second number"

# Convert input to integers
try {
    $num1 = [int]$first
    $num2 = [int]$second
    $sum = GetSum -Num1 $num1 -Num2 $num2
    Write-Host "The sum of $num1 and $num2 is: $sum" -ForegroundColor Magenta
}
catch {
    Write-Host "Invalid number entered for addition!" -ForegroundColor Red
}

Write-Host ""

# Check if a number is even or odd
$checkNum = Read-Host "Enter a number to check if it's Even or Odd"

try {
    $number = [int]$checkNum
    $result = IsEven -Number $number
    Write-Host "$number is $result" -ForegroundColor Green
}
catch {
    Write-Host "Invalid number entered for Even/Odd check!" -ForegroundColor Red
}

Write-Host ""