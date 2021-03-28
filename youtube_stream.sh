#!/bin/sh

sudo v4l2-ctl -c rotate=0,video_bitrate=1000000
sudo v4l2-ctl --set-fmt-video=width=1920,height=1080,pixelformat=4
sudo v4l2-ctl -p 30
sudo v4l2-ctl --overlay=1
sudo v4l2-ctl --set-fmt-overlay top=0,left=0,width=800,height=480

ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i /dev/video0 -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -f flv rtmp://a.rtmp.youtube.com/live2/$1
