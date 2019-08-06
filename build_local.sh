#!/bin/bash -xe

docker build \
  --build-arg "PARAM_UID=$(id -u)" \
  --build-arg "PARAM_GID=$(id -g)" \
  -t murer/xvfb-x11vnc-openbox .
