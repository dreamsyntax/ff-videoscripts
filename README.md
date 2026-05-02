## FFMPEG Scripts for Sharing Videos

### Windows

1. Install [git bash](https://git-scm.com/download/win) from https://git-scm.com
2. Download `ffmpeg-git-essentials.7z` from https://ffmpeg.org/download.html or [click here to grab the direct link from gyan.dev](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-essentials.7z) 
3. Copy out `ffmpeg.exe` and `ffprobe.exe` and put it in the same folder as these scripts.
4. Download this repo or clone it, and copy/move your target .mp4 or .mkv files (or any video files) you want to share into this repo folder.
5. Double click which script you want, which will then find all videos files in the current directory, and copy/converts to [filename]_c.mp4 at the target resolution.

In the future now you just copy/move your video you want to share into this folder, and double click the .sh you want. It's that easy.

### What does this do

Are you too lazy or too impatient to use [HandBrake](https://handbrake.fr/), [VidCoder](https://vidcoder.net/), or other conversion solutions? Set this up once and rapid conversions await!

All scripts scan the current folder, and batch convert / output as an `mp4`. The " - mkv" just means thats what files it will look/convert from.

"mp4 - 720x480 - 8MB.sh" takes in any `mp4`, and makes it 720x480 with a close to ~8MB sizing target `mp4`.

"mp4 - 720x480.sh" takes in any `mp4`, and makes 720x480 optimized `mp4`.

"mkv - 1920x1080.sh" takes in any `mkv`, and makes 1920x1080 optimized `mp4`.

Most of the scripts scripts are just modified version of this, requiring only `ffmpeg.exe`:
```bash
for i in *.mkv;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  ./ffmpeg -i "$i" -vf scale=720:480 -c:v libx264 -preset fast -c:a aac "${name}_c.mp4" -hide_banner;
done
```

The 8MB script is a bit different, requiring `ffprobe.exe`
```bash
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
```

Change out `*.mkv` part for whatever you want to convert FROM.
Change out the `scale=720:480` to whatever resolution you want to output.

### How to video

[YouTube Video: https://youtu.be/oykj6-WEKKc](https://youtu.be/oykj6-WEKKc)