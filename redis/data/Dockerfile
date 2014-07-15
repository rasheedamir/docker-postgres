# Custom container for storage and backup of Redis data

FROM busybox:ubuntu-14.04
MAINTAINER John Allen <john.allen@connexiolabs.com>

RUN mkdir -p /var/lib/redis && \
    mkdir -p /var/log/redis

VOLUME ["/var/log/redis", "/var/lib/redis"]
