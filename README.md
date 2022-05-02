# scripts
**Batch/Powershell scripts that use FFmpeg for various video processing related purposes**
> ***!! AMD GPUs currently not supported !!***

# usage
**if not stated otherwise, all batch scripts in this repo use SendTo logic**
 
### as in; 
- open *Run* using WIN + R and type in `shell:sendto`
- this will prompt you with the Send to folder, into which you drag the desired batch script
- **to use:** select your video(s), right click on one of them, hover over "Send to" and select the script that you wish to use

**NOTE:** the installation scripts provided will automatically add your requested script to the Send to folder

# prerequisites:
 - ffmpeg, can be easily installed via
```powershell
powershell -noe "iex(irm tl.ctt.cx); Get main/ffmpeg" 
```

# the scripts:

## atzurUpscaler

  - upscales video, meant to be used to gain higher bitrate on youtube

**install with:**
```powershell 
powershell "(irm https://github.com/atzuur/scripts/raw/main/atzurupscalerbat) | Out-File (Join-Path ([Environment]::GetFolderPath('SendTo')) atzurUpscaler.bat) -Encoding ASCII"
```

### miscellaneous features
> * point scaling
> * render queue (select multiple videos at once)
> * 4 scaling options
> * terminates automatically if video is already in desired resolution

## reenc

**quick video compressor/converter**

- uses libx264 to efficiently compress video
- should be able to make any 1080p video <40s embeddable on discord (ie. under 100mb)
- supports multiqueue

**install with:**
```powershell 
powershell "(irm https://github.com/atzuur/scripts/raw/main/reenc.bat) | Out-File (Join-Path ([Environment]::GetFolderPath('SendTo')) reenc.bat) -Encoding ASCII"
```

## credits
- ffmpeg installer:
> * https://github.com/couleur-tweak-tips/TweakList
