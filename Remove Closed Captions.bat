for %%a in ("*.mp4*") do ffmpeg -i "%%a" -codec copy -bsf:v "filter_units=remove_types=6" "D:\Encoding Output\%%~na.mp4"
pause