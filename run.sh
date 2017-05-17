#!/bin/bash -xe

docker rm -f xvfb-x11vnc-openbox || true
docker run -it -p 5900:5900 --name xvfb-x11vnc-openbox murer/xvfb-x11vnc-openbox "$@"
