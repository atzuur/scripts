<# : batch portion
title Initialization..
mode con: lines=5
@echo off & (for %%I in ;(%*) do @echo(%%~I) | ^
powershell.exe -noexit -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
: end batch / begin powershell #>

Get-ChildItem $argv | ForEach-Object { # Loops through each queued video

    $round++ # Increments the round counter

    $Host.UI.RawUI.WindowTitle = "[$($round)/$($argv.count)] Encoding $($_.Name)" # Sets the window title with progress indicator and the video that's currently gettign encoded

    [String]$Out = Join-Path $_.Directory ($_.BaseName + ' - reenc.mp4') # Setting up a variable for the output file name

    ffmpeg -i `"$($_.FullName)`" -loglevel warning -stats -c:v libx264 -c:a libopus -preset slow -x264-params aq-mode=3 -crf 19 -b:a 128k -pix_fmt yuv420p10le `"$($out)`" # Actually run the command
    if ($LASTEXITCODE -ne 0){pause} # Pause if there's an error

    if ($round -ne $argv.count){Clear-Host} # Clear the screen until the last video comes through

}
exit