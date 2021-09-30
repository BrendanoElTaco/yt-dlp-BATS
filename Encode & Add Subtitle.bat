cd SHOWS

::Encode subs - Set language to english and default track
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -i "%%~ni.en.srt" -map 0 -map 1 -c copy -metadata:s:s:0 language=eng -disposition:s:s:0 default "D:\Encoding Output\%%~ni.mkv"

D:

cd "D:\Encoding Output"

::Encode all video files into h265_nvenc
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -map 0 -c:v hevc_nvenc -c:a copy -c:s copy -b:v 3000k "D:\File Sorting\%%~ni.mkv"


::Move all VTT to Output
::ROBOCOPY "Z:\Youtube Download\SHOWS" "D:\Encoding Output" *.vtt /S /MOVE

pause

::-cq 25