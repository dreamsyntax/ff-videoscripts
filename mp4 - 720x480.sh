for i in *.mp4;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  ./ffmpeg -i "$i" -vf scale=720:480 -c:v libx264 -preset fast -c:a aac "${name}_c.mp4" -hide_banner;
done