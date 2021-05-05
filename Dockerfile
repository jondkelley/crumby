FROM python:3.9-alpine

MAINTAINER Jonathan Kelley <jonk@omg.lol>

ENV DEBIAN_FRONTEND noninteractive

ADD . /crumby
RUN apk add gcc libc-dev build-base libffi-dev bash \
  && pip3 install -r /crumby/requirements.txt \
  && echo "nameserver 192.168.0.1" >> /etc/resolv.conf

WORKDIR /crumby

RUN python3 setup.py install \
 && crumby geoip \
 && crumby init

EXPOSE 5001
ENTRYPOINT ["crumby"]
