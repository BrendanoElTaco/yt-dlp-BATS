@echo off

::Download Videos
yt-dlp.exe --write-sub --write-auto-sub --convert-sub srt --remux-video mkv -o "D:\Youtube Downloads\DOWNLOADS\Youtube\%%(title)s.%%(ext)s" --batch "D:\Youtube Downloads\Youtube Links.txt"

timeout 2 /nobreak

cd "D:\Youtube Downloads\DOWNLOADS\Youtube"

::Encode subs - Set language to english and default track
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -i "%%~ni.en.srt" -map 0 -map 1 -c copy -metadata:s:s:0 language=eng -disposition:s:s:0 default "D:\Encoding Output\%%~ni.mkv"

del *.* /F /Q

D:

cd "D:\Encoding Output"

::Encode all video files into h265_nvenc
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -map 0 -c:v hevc_nvenc -c:a aac -c:s srt -b:v 2500k "D:\File Sorting\%%~ni.mkv"

pause