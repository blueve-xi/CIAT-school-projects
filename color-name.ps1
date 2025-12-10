# Define the available console colors in an array
$ConsoleColors = @(
    "Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray",
    "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White"
)

# Prompt the user for their name and store the input in a variable
$Name = Read-Host -Prompt "What is your name?"

# Select a random color from the array
$RandomColor = Get-Random -InputObject $ConsoleColors

# Display the greeting using the random color
Write-Host "Hello, $Name! Your random color is $RandomColor." -ForegroundColor $RandomColor
