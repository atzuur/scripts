<# : batch portion
title Initialization...
cls
@echo off & (for %%I in ;(%*) do @echo(%%~I) | ^
powershell.exe -noexit -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
: end batch / begin powershell #>


$EncQ = Read-Host @"
Would you like to Encode using GPU or CPU?
Press 1 for GPU
Press 2 for CPU
 A
"@


switch ($EncQ) {
	1 {	
		$Enc = "-c:v hevc_nvenc -preset p7 -rc vbr -b:v 250M -cq 15" 
		$EncOpts = "HEVC_NVENC (slowest preset, 15 CQ)"
	
	}
	
	2 {
		$Enc = "-pix_fmt yuv420p10le -c:v libx265 -x265-params aq-mode=3:no-sao=1:log-level=none -preset medium -crf 15"
		$EncOpts = "x265 (medium preset, 15 CRF)"
		$EncShort = " (x265)"
	
	}
	
	default {
		Write-Host "Invalid parameters!" -f red
		pause
		exit
	}
}



$ScaleQ = Read-Host @"
What resolution would you like to upscale to?
Press 1 for 1080p
Press 2 for 1440p
Press 3 for 4k
Press 4 for 8k
 A
"@

switch ($ScaleQ) {
	1 {
		$Scale = "1080"
		$ScaleOpts="1080p"	
	}
	
	2 {
		$Scale = "1440"
		$ScaleOpts="1440p"	
	}
	
	3 {
		$Scale = "2160"
		$ScaleOpts="4k"
	}
	
	4 {
		$Scale = "4320"
		$ScaleOpts="8k"	
	}
	
	default {
		Write-Host "Invalid parameters!" -f red
		pause
		exit
	}
}


Clear-Host

mode.com con: lines=5

$inHeight = ffprobe -v error -select_streams v:0 -show_entries stream=height -i $argv -of csv=p=0

if ($inHeight -eq $Scale) {
	Write-Host "ERROR: Video is already in $($ScaleOpts), exiting" -f Red
	Pause
	exit
}


# credits to coler (https://github.com/couleurm) for most of the code below :>
 Get-ChildItem $argv | ForEach-Object { 

	$in = "$_"
   
	$Command = 'ffmpeg -i `"$($in)`" -loglevel warning -stats -vf zscale=-2:$($Scale):f=bicubic {0} -c:a libopus -b:a 128k `"$($Out)`"' -f $Enc

    $round++ 

    $Host.UI.RawUI.WindowTitle = "[$($round)/$($argv.count)] Currently processing: $($_.Name) (Upscaling to $($ScaleOpts), Encoding using $($EncOpts)" 

	$Out = Join-Path $_.Directory ($_.Basename + " - $($ScaleOpts)$($EncShort).mp4") 

    Invoke-Expression $Command 
    
	if ($LASTEXITCODE -ne 0){pause} 

    if ($round -ne $argv.count){Clear-Host} 

	

}

exit



