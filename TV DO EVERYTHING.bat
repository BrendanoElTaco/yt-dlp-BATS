@echo off

::Download Videos
yt-dlp.exe --ap-mso ATT --ap-username "USERNAME" --ap-password "PASSWORD" --downloader aria2c --remux-video mkv -o "D:\Youtube Downloads\DOWNLOADS\TV\%%(series)s - S%%(season_number)s E%%(episode_number)s - %%(title)s.%%(ext)s" --batch "D:\Youtube Downloads\TV Links.txt"

::Download Subs
yt-dlp.exe --ap-mso ATT --ap-username "USERNAME" --ap-password "PASSWORD" --skip-download --downloader aria2c --write-sub --convert-subs srt -o "D:\Youtube Downloads\DOWNLOADS\TV\%%(series)s - S%%(season_number)s E%%(episode_number)s - %%(title)s.%%(ext)s" --batch "D:\Youtube Downloads\TV Links.txt"

cd "D:\Youtube Downloads\DOWNLOADS\TV"

::Encode subs - Set language to english and default track
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -i "%%~ni.en.srt" -map 0 -map 1 -c copy -metadata:s:s:0 language=eng -disposition:s:s:0 default "D:\Encoding Output\%%~ni.mkv"

del *.* /F /Q

D:

cd "D:\Encoding Output"

::Encode all video files into h265_nvenc
for %%i in ("*.mkv*") do ffmpeg -i "%%i" -map 0 -c:v hevc_nvenc -c:a copy -c:s copy -b:v 2500k "D:\File Sorting\%%~ni.mkv"

pause