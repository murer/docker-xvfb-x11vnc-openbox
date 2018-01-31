#!/bin/bash -xe

param_version="${1?'Version: 0.0.1'}"

./build.sh

export DOCKER_ID_USER="murer"
export DOCKER_IMAGE_NAME="$DOCKER_ID_USER/xvfb-x11vnc-openbox"

docker login

docker tag "$DOCKER_IMAGE_NAME" "$DOCKER_IMAGE_NAME:$param_version"

docker push "$DOCKER_IMAGE_NAME:$param_version"
