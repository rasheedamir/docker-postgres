#!/bin/bash

PROJECT_NAME=docker-postgres
VERSION=${1:-latest}
DOCKER_URI=${2:-tcp://localhost:4444}


DOCKER_PROJECT=docker.amz.relateiq.com/$PROJECT_NAME:$VERSION

echo building docker container $DOCKER_PROJECT && 
	docker -H $DOCKER_URI build --rm -t $DOCKER_PROJECT . &&
	echo publishing $DOCKER_PROJECT to $DOCKER_URI &&
	docker -H $DOCKER_URI push $DOCKER_PROJECT



