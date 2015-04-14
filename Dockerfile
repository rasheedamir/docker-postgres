FROM postgres:9.4

MAINTAINER Jean-Marc <jeanmarc.soumet@relateiq.com>

ENV PG_EXTENSION_VERSION 9.4
ENV POSTGIS_VERSION 2.1
ENV TEMPORAL_TABLES_VERSION 1.0.1
ENV MONGODB_VERSION 2.0.0
ENV HASHTYPES_VERSION 0.1.1

WORKDIR /tmp

RUN apt-get -y update && \
    apt-get install -y wget protobuf-c-compiler libprotobuf-c0-dev && \

    # postgis
    echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get install -y \
        unzip \
        build-essential \
        postgresql-server-dev-$PG_EXTENSION_VERSION \
        postgresql-$PG_EXTENSION_VERSION-postgis-$POSTGIS_VERSION \
        postgis && \

    # cstore_fdw
    cd /tmp && \
    wget --quiet --no-check-certificate -O cstore_fdw.zip \
    https://codeload.github.com/citusdata/cstore_fdw/zip/master && \
    unzip cstore_fdw.zip && \
    cd cstore_fdw-master && \
    PATH=/usr/local/pgsql/bin/:$PATH make && \
    PATH=/usr/local/pgsql/bin/:$PATH make install && \
    

    # temporal_tables
    wget --quiet \
         --no-check-certificate \
        -O temporal_tables-$TEMPORAL_TABLES_VERSION.zip \
        https://github.com/arkhipov/temporal_tables/archive/v$TEMPORAL_TABLES_VERSION.zip && \
    unzip temporal_tables-$TEMPORAL_TABLES_VERSION && \
    cd temporal_tables-$TEMPORAL_TABLES_VERSION && \
    make && \
    make install && \
    cd /tmp && \

    # mongo_fdw
    wget --quiet \
        --no-check-certificate \
        -O mongo_fdw-$MONGODB_VERSION.zip \
        http://api.pgxn.org/dist/mongo_fdw/$MONGODB_VERSION/mongo_fdw-$MONGODB_VERSION.zip && \
    unzip mongo_fdw-$MONGODB_VERSION && \
    cd /tmp/mongo_fdw-$MONGODB_VERSION && \
    make clean && \
    make -C mongo-c-driver-v0.6 all && \
    make && \
    make install && \
    cd /tmp && \

    # hashtypes
    wget --quiet \
        --no-check-certificate \
        -O hashtypes-$HASHTYPES_VERSION.zip \
        http://api.pgxn.org/dist/hashtypes/$HASHTYPES_VERSION/hashtypes-$HASHTYPES_VERSION.zip && \
    unzip hashtypes-$HASHTYPES_VERSION && \
    cd /tmp/hashtypes-$HASHTYPES_VERSION && \
    make clean && \
    make && \
    make install && \
    cd /usr/share/postgresql/$PG_EXTENSION_VERSION/extension/ && \
    cp hashtypes--$HASHTYPES_VERSION.sql hashtypes--0.1.sql && \
    cd /tmp && \

    # cleanup
    apt-get clean && \
    rm -Rf /var/cache/apt && \
    rm -r /tmp/*
