## FFMPEG Scripts for Sharing Videos

### Windows

1. Install [git bash](https://git-scm.com/download/win) from https://git-scm.com
2. Download `ffmpeg-git-essentials.7z` from https://ffmpeg.org/download.html or [click here to grab the direct link from gyan.dev](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-essentials.7z) 
3. Copy out ffmpeg.exe and put it in the same folder as these scripts.
4. Download this repo or clone it, and copy/move your target .mp4 or .mkv files (or any video files) you want to share into this repo folder.
5. Double click which script you want, which will then find all videos files in the current directory, and copy/converts to [filename]_c.mp4 at the target resolution.

Congratulations. In the future now you just copy/move your video you want to share into this folder, and double click the .sh you want. It's that easy.

### What does this do

All scripts scan the current folder, and batch convert / output as an mp4. The " - mkv" just means thats what files it will look/convert from.

"720x480.sh" takes in any mp4, and makes 720x480 optimized mp4.
"1920x1080 - mkv.sh" takes in any mkv, and makes 1920x1080 optimzed mp4.

All scripts are just modified version of this:
```bash
for i in *.mkv;
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;
  ./ffmpeg -i "$i" -vf scale=720:480 -c:v libx264 -preset fast -c:a aac "${name}_c.mp4" -hide_banner;
done
```

Changing out `*.mkv` part for whatever you want to convert FROM.
Changing out the `scale=720:480` to whatever resolution you want to output.

### How to video

YouTube Link or something