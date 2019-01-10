#!/bin/bash
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz

mkdir ffmpeg-64bit-static-build

tar xf ffmpeg-git-64bit-static.tar.xz -C ffmpeg-64bit-static-build --strip-components 1

mv ffmpeg-64bit-static-build/ ffmpeg/

rm ffmpeg-git-64bit-static.tar.xz

pip install -r /tmp/requirements.txt
