@echo off
set container=mp4
color 0D
echo Encoding... 
echo\

:: question(s)
:q
set /p enc=Do you wish to encode with CPU or GPU?: 
    if %enc% == gpu goto :cond
    if %enc% == GPU goto :cond
	color 0C
	echo Invalid encoder!
	goto :q
	:cond
	set %encarg%=-c:v hevc_nvenc -preset p7 -rc vbr -b:v 250M -cq 15
	
	if %enc% == cpu goto :cond2
    if %enc% == CPU goto :cond2
	color 0C
	echo Invalid encoder!
	goto :q2
	:cond2
	set %encarg%=-c:v libx265 -x265-params aq-mode=3:no-sao=1:log-level=full: -preset medium -crf 15


:: ffmpeg
ffmpeg -loglevel quiet -stats -i %1 ^
-vf "zscale=-1:2160:f=bicubic,unsharp=5:5:2" ^
-pix_fmt yuv420p10le %encarg% ^
-c:a copy -map 0 -strict -2 "%~dpn1 (upscaled).%container%"

:: End
echo\&cls
echo ^<3
echo\
color 0A
pause
exit

