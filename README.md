# Docker Images

This repository contains the Dockerfiles for all of the building block images that Connexio Labs uses for app and service related images.

## Making Changes

If a changes is made to one of the Dockerfiles the image should be re-built and pushed to the docker index.

```sh
cd base
docker build --tag connexiolabs/base .
docker push connexiolabs/base
```

If you receive an error about authentication run `docker login` and follow prompts.
