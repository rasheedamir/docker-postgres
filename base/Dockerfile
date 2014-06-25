FROM ubuntu:12.04

MAINTAINER John Allen <john.allen@connexiolabs.com>

ENV DEBIAN_FRONTEND noninteractive

# REPOS
RUN apt-get -y update
RUN apt-get install -yq aptitude python-software-properties
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

