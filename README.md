# scripts
**Batch scripts that use FFmpeg for various video processing related purposes**
> ***!! AMD GPUs currently not supported !!***

# usage
**if not stated otherwise, all batch scripts in this repo use SendTo logic**
 
### as in; 
- open *Run* using WIN + R and type in `shell:sendto`
- this will prompt you with the Send to folder, into which you drag the desired batch script
- **to use:** right click on your video, hover over "Send to" and select the script that you wish to use

**NOTE:** the installation scripts provided with each batch file automatically add your requested script to the Send to folder

# the scripts:

## tiktokifier | install via `powershell "iex(irm is.gd/tiktokifier)"` (paste into WIN + R)
  - formats video from landscape to portrait (16:9 -> 9:16) without black bars
  - frame blends using FFmpeg's *tmix* (~1.6 blending intensity, equal weights)
  - option for upscaling, *hqx* filter
  - ability to trim video

### miscellaneous features
> respond with "hi" to the first question (lol)

> frame deduplication via `mpdecimate=2`

> efficient *HEVC_NVENC* encoding with True VBR

### **! dev note: tiktokifier is deprecated for now, updates coming later (maybe)**

## atzurUpscaler | install via `powershell "iex(irm is.gd/upscaler)"` (paste into WIN + R)
  - upscales video to 4k as efficiently as possible
  - 2 encoding presets; CPU and GPU\
      both presets use *HEVC*, CPU via *libx265* and GPU via *HEVC_NVENC* with True VBR
  - in case you're unaware, CPU (software) encoding is slower but more efficient (less filesize for the same quality) than GPU encoding, which is fast but inefficient.

### miscellaneous features
> bicubic scaling

> sharpening filter for extra crispy video [`unsharp=5:5:2`]

      
