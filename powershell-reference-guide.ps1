# ==========================================
# PowerShell Command Reference Guide
# ==========================================
# For CountdownScript.ps1 Lab
# This guide explains each command used in the script,
# along with short examples you can test in PowerShell.
# ==========================================


# -------------------------
# 1. Read-Host
# -------------------------
# Description:
# Prompts the user to enter input (text or numbers).
#
# Syntax:
#   Read-Host "Prompt message"
#
# Example:
$name = Read-Host "Please enter your name"
Write-Host "Hello, $name!"
# Prompts the user and stores their response in $name.


# -------------------------
# 2. Write-Host
# -------------------------
# Description:
# Displays text or variable values directly to the PowerShell console.
#
# Syntax:
#   Write-Host "message"
#
# Example:
Write-Host "PowerShell is fun!"
Write-Host "Hello, $name!"
# Use to print text or combine text with variable values.


# -------------------------
# 3. Variables ($)
# -------------------------
# Description:
# Variables store values (text, numbers, etc.) that can be reused.
#
# Syntax:
#   $variableName = value
#
# Examples:
$name = "Alex"
$number = 5
Write-Host "Name:" $name " Number:" $number
# Variables always start with the $ symbol.


# -------------------------
# 4. Type Casting [int]
# -------------------------
# Description:
# Converts one data type to another (for example, text to a number).
#
# Syntax:
#   [int]$variable
#
# Example:
$input = Read-Host "Enter a number"
$number = [int]$input
# Ensures the input is treated as an integer (a whole number).


# -------------------------
# 5. if Statement
# -------------------------
# Description:
# Runs code only if a condition is true (optional else part runs if false).
#
# Syntax:
#   if (<condition>) {
#       # Code if true
#   } else {
#       # Code if false
#   }
#
# Example:
$age = 18
if ($age -ge 18) {
    Write-Host "You are an adult."
} else {
    Write-Host "You are not an adult yet."
}
# -ge means "greater than or equal to".
# Other comparison operators include -eq, -lt, -gt, -le, -ne.


# -------------------------
# 6. for Loop
# -------------------------
# Description:
# Repeats code a specific number of times.
#
# Syntax:
#   for ($i = start; $i -condition; $i = $i ± 1) {
#       # Code to repeat
#   }
#
# Example:
for ($i = 5; $i -ge 1; $i--) {
    Write-Host $i
}
# Prints 5, 4, 3, 2, 1 (a countdown).


# -------------------------
# 7. Start-Sleep
# -------------------------
# Description:
# Pauses the script for a number of seconds (or milliseconds).
#
# Syntax:
#   Start-Sleep -Seconds <number>
#
# Example:
Write-Host "Wait for 3 seconds..."
Start-Sleep -Seconds 3
Write-Host "Done waiting!"
# Used to slow down output, useful for countdowns.


# -------------------------
# 8. New Line (`n)
# -------------------------
# Description:
# Adds a line break (new line) inside text output.
#
# Syntax:
#   `n
#
# Example:
Write-Host "Line 1`nLine 2"
# Outputs:
# Line 1
# Line 2


# -------------------------
# 9. Comparison Operators
# -------------------------
# Description:
# Used to compare two values in conditions.
#
# Examples (assuming $a = 5, $b = 3):
#   -eq : Equal to           -> ($a -eq $b) is False
#   -ne : Not equal to       -> ($a -ne $b) is True
#   -gt : Greater than       -> ($a -gt $b) is True
#   -lt : Less than          -> ($a -lt $b) is False
#   -ge : Greater or equal   -> ($a -ge $b) is True
#   -le : Less or equal      -> ($a -le $b) is False


# ==========================================
# End of PowerShell Reference Guide
# ==========================================



# Run the script
# --------------------------
# Use .\ followed by your script name:
.\NameOfScriptHere.ps1
