for i in *.mkv;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  ./ffmpeg -i "$i" -c:v libx264 -preset fast -c:a aac "${name}_c.mp4" -hide_banner;
done