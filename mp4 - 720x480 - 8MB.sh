for i in *.mp4;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  duration=$(./ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$i" | tr -d '\r\n');
  video_bitrate=$(awk -v d="$duration" 'BEGIN {print int((67109/d)-128)}');
  echo "Duration: ${duration}s  Video bitrate: ${video_bitrate}k";
  ./ffmpeg -i "$i" -vf scale=720:480 -c:v libx264 -preset fast -b:v "${video_bitrate}k" -pass 1 -an -f null - -hide_banner;
  ./ffmpeg -i "$i" -vf scale=720:480 -c:v libx264 -preset fast -b:v "${video_bitrate}k" -pass 2 -c:a aac -b:a 128k "${name}_8mb.mp4" -hide_banner;
  rm -f ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree;
done
