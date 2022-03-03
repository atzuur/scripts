Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# scoop check
if (!(Get-Command scoop -ea ignore)) {
    Write-Host "    Installing Scoop...`r`n" -f yellow
    Invoke-Expression(Invoke-RestMethod get.scoop.sh)
}
else {
    Write-Host "Scoop is already installed!" -f green
}

"`r`n"

# git check
if (!(Get-Command git -ea Ignore)) {
    Write-Host "    Installing Git...`r`n" -f yellow
    scoop install git
    Clear-Host
    Write-Host "Git installed succesfully!" -f green
}

else {
    Write-Host "Git is already installed!" -f green
    scoop update git
}

"`r`n"

# ffmpeg check
if (!(Get-Command ffmpeg -ea Ignore)) {
    Write-Host "    Installing FFmpeg...`r`n" -f yellow
    scoop install ffmpeg
    Write-Host "FFmpeg has been installed succesfully!" -f green
}

else {
    Write-Host "FFmpeg is already installed!" -f green
    scoop update ffmpeg
}

"`r`n"

# download atzurUpscaler and direct to the SendTo folder
$SendTo = [Environment]::GetFolderPath('SendTo')

# check for an existing installation
if ((Test-Path -Path $SendTo\atzurUpscaler.bat -PathType Leaf)) {

    $Option = Read-Host @"
atzurUpscaler is already in the SendTo folder, what would you like to do?
Press O to overwrite (update atzurUpscaler)
Press E to exit
"@

# convert input to lowercase (idk if this is necessary)
$Option.ToLower()

# overwrite existing file / exit
if ($Option -eq "o") {
    Write-Host "Overwriting..."
    Remove-Item $SendTo\atzurUpscaler.bat -Force
}else {
    exit
}

}

# download and install the script
Write-Host "Installing atzurUpscaler..." -f yellow

Invoke-RestMethod https://raw.githubusercontent.com/atzuur/scripts/main/atzurUpscaler.bat | out-file "$SendTo\atzurUpscaler.bat" -encoding ascii

Write-Host "atzurUpscaler has succesfully been installed and added to SendTo!" -f green

pause
exit