#!/usr/bin/env bash
set -euo pipefail

ROOT="/tmp/hello-hub"
SRC="/tmp/cenas_maria_daniel"
WORK="/tmp/maria_video_work"
OUT="$ROOT/public/maria-daniel-narrado-9x16.mp4"
mkdir -p "$WORK" "$ROOT/public"
rm -f "$WORK"/*.mp4 "$WORK"/concat.txt "$OUT"

# Durations follow the narrative beats across the 18 supplied scenes.
durations=(14 14 14 14 14 14 15 15 15 16 16 16 16 16 16 17 16 26)
for i in $(seq 1 18); do
  img=$(printf "%s/cena_%02d.jpg" "$SRC" "$i")
  seg=$(printf "%s/seg_%02d.mp4" "$WORK" "$i")
  dur=${durations[$((i-1))]}
  frames=$((dur*30))
  if (( i % 2 == 1 )); then
    motion="zoompan=z='min(zoom+0.00075,1.12)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=${frames}:s=1080x1920:fps=30"
  else
    motion="zoompan=z='if(lte(zoom,1.001),1.12,max(1.0,zoom-0.00075))':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=${frames}:s=1080x1920:fps=30"
  fi
  ffmpeg -y -loglevel error -loop 1 -i "$img" -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,${motion},format=yuv420p,fade=t=in:st=0:d=0.45,fade=t=out:st=$((dur-0)).45:d=0.45" -t "$dur" -r 30 -c:v libx264 -preset medium -crf 20 -movflags +faststart "$seg"
  printf "file '%s'\n" "$seg" >> "$WORK/concat.txt"
done
ffmpeg -y -loglevel error -f concat -safe 0 -i "$WORK/concat.txt" -c copy "$WORK/video_only.mp4"
ffmpeg -y -loglevel error -i "$WORK/video_only.mp4" -i "/home/ubuntu/upload/lv_0_20260913143337.mp4" -map 0:v:0 -map 1:a:0 -c:v copy -c:a aac -b:a 192k -shortest -movflags +faststart "$OUT"
ffprobe -v error -show_entries format=duration,size:stream=codec_name,width,height,sample_rate,channels -of json "$OUT"
