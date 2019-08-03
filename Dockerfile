FROM ubuntu:18.04

MAINTAINER Paulo Murer

RUN apt-get update

RUN apt-get install -y wget curl xvfb x11vnc xterm vim \
                       firefox openbox tint2 lxterminal \
                       gmrun pcmanfm

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN apt-get -y install google-chrome-stable

ADD config /opt/config

RUN chmod +x /opt/config/docker-entrypoint.sh /opt/config/openbox/autostart

RUN rm -rf /etc/xdg/openbox && \
    cp -R /opt/config/openbox /etc/xdg/openbox

ENV DISPLAY :99
EXPOSE 5900

CMD "/opt/config/docker-entrypoint.sh"
