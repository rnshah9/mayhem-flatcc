FROM --platform=linux/amd64 ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build clang cmake

ADD . /flatcc
WORKDIR /flatcc
RUN ./scripts/build.sh
