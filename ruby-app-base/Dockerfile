FROM connexiolabs/app-base:latest

MAINTAINER John Allen <john.allen@connexiolabs.com>

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

# Install latest ruby version
RUN ruby-build -v 2.1.2 /usr/local

# Install base gems
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri

# Regenerate binstubs
RUN gem regenerate_binstubs

# install commonly used software
RUN apt-get install -y -q postgresql-client
