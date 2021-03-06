<# : batch portion
title Initialization..
mode con: lines=5
@echo off & (for %%I in ;(%*) do @echo(%%~I) | ^
powershell.exe -noexit -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
: end batch / begin powershell #>

Get-ChildItem $argv | ForEach-Object {

    $round++

    $Host.UI.RawUI.WindowTitle = "[$($round)/$($argv.count)] Encoding $($_.Name)"

    [String]$Out = Join-Path $_.Directory ($_.BaseName + ' - reenc.mp4')

    ffmpeg -i `"$($_.FullName)`" -loglevel warning -stats -c:v libx264 -c:a aac -preset slower -x264-params aq-mode=3 -crf 18 -b:a 256k -pix_fmt yuv420p `"$($out)`"
    if ($LASTEXITCODE -ne 0){pause}

    if ($round -ne $argv.count){Clear-Host}
}
exit
