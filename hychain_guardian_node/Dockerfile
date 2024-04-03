FROM ubuntu:22.04 AS base

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN git clone https://github.com/HYCHAIN/guardian-node-software
RUN echo $LOOP_INTERVAL_MS

# arm64-specific stage
FROM base AS build-arm64
RUN echo "Building arm64 version"
WORKDIR /guardian-node-software/cli/linux-arm64
RUN chmod -R +x *
ENTRYPOINT ./guardian-cli-linux-arm64 guardian run $PRIVATE_KEY --loop-interval-ms $LOOP_INTERVAL_MS

# amd64-specific stage
FROM base AS build-amd64
RUN echo "Building amd64 version"
WORKDIR /guardian-node-software/cli/linux
RUN chmod -R +x *
ENTRYPOINT ./guardian-cli-linux guardian run $PRIVATE_KEY --loop-interval-ms $LOOP_INTERVAL_MS

FROM build-${TARGETARCH} AS build
RUN echo "This stage is used on all archs"

