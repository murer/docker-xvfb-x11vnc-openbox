FROM ubuntu:14.04

MAINTAINER Paulo Murer

RUN sed -i "s/\/\/us\.archive\.ubuntu\.com/\/\/br.archive.ubuntu.com/g" /etc/apt/sources.list
RUN sed -i "s/\/\/archive\.ubuntu\.com/\/\/br.archive.ubuntu.com/g" /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y wget curl xvfb x11vnc xterm vim \
                       firefox openbox tint2 lxterminal \
                       gmrun pcmanfm

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
RUN sudo apt-get update
RUN sudo apt-get -y install google-chrome-stable

ADD config /opt/config

RUN chmod +x /opt/config/docker-entrypoint.sh /opt/config/openbox/autostart

RUN rm -rf /etc/xdg/openbox && \
    cp -R /opt/config/openbox /etc/xdg/openbox

ENV DISPLAY :99
EXPOSE 5900

CMD "/opt/config/docker-entrypoint.sh"
