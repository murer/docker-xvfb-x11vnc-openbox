# Virtual X and VNC server docker image

Build

```shell
docker build -t murer/xvfb-x11vnc-openbox .
```

Run

```shell
docker run -it -p 5900:5900 --name xvfb-x11vnc-openbox murer/xvfb-x11vnc-openbox
```

Connect

```shell
# apt-get install xtightvncviewer
vncviewer localhost:5900
```
