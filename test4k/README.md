# 4K test clips

Six-second test patterns for PineIPTV's 4K Test (*Settings > Playback*), which
plays each one with the TV's own player and shows which 4K formats the TV
decodes. Each clip names its format on screen.

| File | Video |
|---|---|
| `fhd-hevc10-50.mp4` | 1920 × 1080, HEVC Main 10, 50 fps (control) |
| `4k-hevc8-25.mp4` | 3840 × 2160, HEVC Main, 25 fps |
| `4k-hevc8-50.mp4` | 3840 × 2160, HEVC Main, 50 fps |
| `4k-hevc10-25.mp4` | 3840 × 2160, HEVC Main 10, 25 fps |
| `4k-hevc10-50.mp4` | 3840 × 2160, HEVC Main 10, 50 fps |
| `4k-hevc10-50-hlg.mp4` | 3840 × 2160, HEVC Main 10, 50 fps, HLG |
| `4k-hevc10-50-hlg.ts` | the same in MPEG-TS, as IPTV channels send it |
| `4k-h264-25.mp4` | 3840 × 2160, H.264 High, 25 fps |
| `4k-h264-50.mp4` | 3840 × 2160, H.264 High, 50 fps |

`gen.sh` makes them with FFmpeg (x264, x265) from its `testsrc2` pattern.
