FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /

RUN apt-get -qq update \
  && apt-get install -y software-properties-common \
  && apt-add-repository -y ppa:mc3man/trusty-media \
  && apt-get -qq update \
  && apt-get install -y \
    git \
    mkvtoolnix \
    gpac \
    ffmpeg \
    python \
  && apt-get clean autoclean \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN git clone https://github.com/gavinbeatty/mkvtomp4.git /app
RUN cd /app && git checkout -f 99c3ef97cd353b2afa98204a83e74caaab70cb09
RUN cd /app && python setup.py install

ADD entrypoint.sh .
