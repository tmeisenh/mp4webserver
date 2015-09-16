mp4webserver
=========
Sample application that demonstrates major memory issues with mediaserverd.

To use, install ffmpeg.  (Homebrew makes this easiest: `brew install ffmpeg`).
```bash
cd videos/
./ffmpeg_encode.sh
./server.sh
```
Build and run app.  Tap on "Serve Movie Up!!" and observe mediaserverd and its memory usage.
Using instruments we observed memory usage going from ~10MB on a freshly booted iPad3 to ~250MB after one minute of playing the video.
