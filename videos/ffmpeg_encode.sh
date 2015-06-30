#!/bin/bash

MOVIE="big_buck_bunny_720p_5mb.mp4"
PLAYLIST="playlist.m3u8"
OUTDIR=.
HTTPURL="http://127.0.0.1:8080/mp4"

wget -c http://sample-videos.com/video/mp4/720/big_buck_bunny_720p_5mb.mp4
ffmpeg -i ${MOVIE} -vcodec libx264 -bsf:v h264_mp4toannexb -flags -global_header -dcodec copy -acodec copy -q:v 0 -map 0 -f segment -segment_list ${PLAYLIST} -segment_time 10 -segment_list_flags +live -reset_timestamps 1 -segment_list_entry_prefix ${HTTPURL} ${OUTDIR}/%06d.ts
