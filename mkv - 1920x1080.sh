for i in *.mkv;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  ./ffmpeg -i "$i" -vf scale=1920:1080 -c:v libx264 -preset fast -c:a aac "${name}_c.mp4" -hide_banner;
done