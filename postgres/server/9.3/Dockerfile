FROM postgres:9.3

MAINTAINER John Allen <john.allen@connexiolabs.com>

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list \
    && apt-get -y update \
    && apt-get -y install postgresql-9.3-postgis-2.1 postgis libossp-uuid-dev
