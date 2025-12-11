# Wallpaper Cycler - Changes wallpaper every minute from "My Photos" folder
# Save as: WallpaperCycler.ps1  (Run in PowerShell as Administrator recommended for first run)

try {
    # Define the folder path
    $FolderPath = "$env:USERPROFILE\Pictures\My Photos"

    # Create the folder if it doesn't exist
    if (-not (Test-Path -Path $FolderPath)) {
        New-Item -ItemType Directory -Path $FolderPath -Force | Out-Null
        Write-Host "Created folder: $FolderPath" -ForegroundColor Green
        Write-Host "Please add some photos (JPG/PNG/BMP) to the folder and run the script again." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit
    }

    # Get all image files
    $Images = Get-ChildItem -Path $FolderPath -Include *.jpg, *.jpeg, *.png, *.bmp -File -Recurse -ErrorAction Stop

    if ($Images.Count -eq 0) {
        Write-Host "No images found in '$FolderPath'." -ForegroundColor Red
        Write-Host "Please add some photos (JPG, JPEG, PNG, BMP) and try again." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit
    }

    Write-Host "Found $($Images.Count) image(s). Starting wallpaper cycle every 60 seconds..." -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop." -ForegroundColor Gray

    # Add Windows API calls to change wallpaper
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

    while ($true) {
        foreach ($Image in $Images) {
            $FullPath = $Image.FullName

            # Set wallpaper (SPI_SETDESKWALLPAPER = 20, SPIF_UPDATEINIFILE = 0x01, SPIF_SENDWININICHANGE = 0x02)
            [Wallpaper]::SystemParametersInfo(20, 0, $FullPath, 0x01 -bor 0x02) | Out-Null

            # Show current wallpaper name
            Write-Host "$(Get-Date -Format 'HH:mm:ss') - Wallpaper set to: $($Image.Name)" -ForegroundColor Green

            # Wait 60 seconds
            Start-Sleep -Seconds 60
        }
    }
}
catch {
    Write-Host ""
    Write-Host "We have run into an issue, come back later." -ForegroundColor Red
    Write-Host "Error details: $($_.Exception.Message)" -ForegroundColor DarkRed
    Read-Host "Press Enter to exit"
}
