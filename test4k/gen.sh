#!/bin/sh
# Synthetic 6 s test clips for PineIPTV's 4K test: a moving test pattern
# labelled with what it is, in the formats IPTV 4K channels use.
set -e
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
OUT=/tmp/claude-0/test4k/out
clip() { # name size fps label vcodec-args...
  name=$1; size=$2; fps=$3; label=$4; shift 4
  ffmpeg -hide_banner -loglevel error -y -f lavfi -i "testsrc2=size=$size:rate=$fps" -t 6 \
    -vf "drawtext=fontfile=$FONT:text='$label':fontsize=h/14:fontcolor=white:x=(w-tw)/2:y=h*0.08:box=1:boxcolor=black@0.65:boxborderw=24,drawtext=fontfile=$FONT:text='%{n}':fontsize=h/18:fontcolor=yellow:x=(w-tw)/2:y=h*0.85:box=1:boxcolor=black@0.65:boxborderw=16" \
    "$@" "$OUT/$name"
  echo "$name $(stat -c %s "$OUT/$name")"
}
X265="-c:v libx265 -preset ultrafast -crf 30 -x265-params log-level=error -tag:v hvc1"
X264="-c:v libx264 -preset veryfast -crf 30"
clip 4k-hevc8-25.mp4 3840x2160 25 '4K HEVC 8-bit 25 fps' $X265 -pix_fmt yuv420p -movflags +faststart
clip 4k-hevc8-50.mp4 3840x2160 50 '4K HEVC 8-bit 50 fps' $X265 -pix_fmt yuv420p -movflags +faststart
clip 4k-hevc10-25.mp4 3840x2160 25 '4K HEVC 10-bit 25 fps' $X265 -pix_fmt yuv420p10le -movflags +faststart
clip 4k-hevc10-50.mp4 3840x2160 50 '4K HEVC 10-bit 50 fps' $X265 -pix_fmt yuv420p10le -movflags +faststart
HLG="-color_primaries bt2020 -color_trc arib-std-b67 -colorspace bt2020nc"
clip 4k-hevc10-50-hlg.mp4 3840x2160 50 '4K HEVC 10-bit 50 fps HLG' -c:v libx265 -preset ultrafast -crf 30 -tag:v hvc1 -x265-params log-level=error:colorprim=bt2020:transfer=arib-std-b67:colormatrix=bt2020nc -pix_fmt yuv420p10le $HLG -movflags +faststart
clip 4k-hevc10-50-hlg.ts 3840x2160 50 '4K HEVC 10-bit 50 fps HLG (TS)' -c:v libx265 -preset ultrafast -crf 30 -x265-params log-level=error:colorprim=bt2020:transfer=arib-std-b67:colormatrix=bt2020nc:repeat-headers=1 -pix_fmt yuv420p10le $HLG -f mpegts
clip 4k-h264-25.mp4 3840x2160 25 '4K H.264 25 fps' $X264 -pix_fmt yuv420p -profile:v high -level 5.1 -movflags +faststart
clip 4k-h264-50.mp4 3840x2160 50 '4K H.264 50 fps' $X264 -pix_fmt yuv420p -profile:v high -level 5.2 -movflags +faststart
clip fhd-hevc10-50.mp4 1920x1080 50 'Full HD HEVC 10-bit 50 fps' $X265 -pix_fmt yuv420p10le -movflags +faststart
