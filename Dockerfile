FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /

RUN apt-get -qq update \
  && apt-get install -y \
    libav-tools \
    curl \
  && apt-get clean autoclean \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD entrypoint.sh .
CMD ["/entrypoint.sh"]
