FROM --platform=linux/amd64 ubuntu:20.04 as builder
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build clang cmake

ADD . /flatcc
WORKDIR /flatcc
RUN ./scripts/build.sh

RUN mkdir -p /deps
RUN ldd /flatcc/bin/flatcc | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /flatcc/bin/flatcc /flatcc/bin/flatcc
ENV LD_LIBRARY_PATH=/deps
