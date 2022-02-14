@echo off
set container=mp4
color 0f
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)

:: QUESTIONS
set /p bye=hi! 
	if NOT %bye%==hi (
	echo\
	color 0C
	echo ^:(^ & pause
	exit /B
)
cls
set /p infps=FPS of your input file: 
set /p outfps=FPS you want to render in: 
cls
set /p start=Where do you want your clip to start (in seconds): 
set /p time=How long after the start time do you want it to be: 
cls
set /p upscale=Do you want to upscale to 4k^? (only do this for YouTube) [yes or no]: 


:: variabl stuf
set /A infps=%infps%*100
set /A tmixframes=%infps%/%outfps%
set /A tmixframes=%tmixframes%/60
set /A vl=%time%-%start%

:: upscaling
if %upscale%0 == yes0  (
	set upscaling=,hqx=2
)

:: Running
echo\&cls
color 0D
echo atzur luvs uuu                                        
echo making video look nice...                    progress ^|^|
echo                                                       \/
echo\


:: ffmpeg
ffmpeg -loglevel quiet -stats ^
-ss %start% -t %time% -i %1 ^
-vf "crop=in_w-1313:in_h, scale=1080:1920, mpdecimate=max=2, tmix=frames=%tmixframes%:weights="1", fps=%outfps%%upscaling%" ^
-rc vbr -c:v hevc_nvenc -cq 17 -b:v 240M -preset p7 ^
-c:a copy -map 0 -strict -2 -vsync vfr "%~dpn1 (tiktoked).%container%"

:: End
echo\&cls
echo ^<3
echo\
color 0A
pause