#!/bin/bash -xe

cmd_build() {
  docker build \
    -t murer/xvfb-x11vnc-openbox .
}

cmd_build_local() {
  docker build \
    --build-arg "PARAM_UID=$(id -u)" \
    --build-arg "PARAM_GID=$(id -g)" \
    -t murer/xvfb-x11vnc-openbox .
}

cmd_client() {
  vncviewer localhost:5900
}

cmd_push() {
  param_version="${1?'Version: 0.0.1'}"
  ./build.sh
  DOCKER_ID_USER="murer"
  DOCKER_IMAGE_NAME="$DOCKER_ID_USER/xvfb-x11vnc-openbox"
  docker login
  docker tag "$DOCKER_IMAGE_NAME" "$DOCKER_IMAGE_NAME:$param_version"
  docker push "$DOCKER_IMAGE_NAME:$param_version"
  docker push "$DOCKER_IMAGE_NAME:latest"
}

cmd_exec() {
  docker exec -it xvfb-x11vnc-openbox "$@"
}

cmd_run() {
  docker rm -f xvfb-x11vnc-openbox || true
  docker run -it -p 5900:5900 --name xvfb-x11vnc-openbox murer/xvfb-x11vnc-openbox "$@"
}

cd "$(dirname "$0")"; _cmd="${1?"cmd is required"}"; shift; "cmd_${_cmd}" "$@"
