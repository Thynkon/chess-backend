# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20221004-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.14.2-erlang-25.1.2-debian-bullseye-20221004-slim
#
ARG DEBIAN_VERSION=bullseye-20221004-slim

ARG BUILDER_IMAGE="debian:${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM --platform=linux/amd64 ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential git wget g++ make curl && \
    apt-get clean && \
    rm -f /var/lib/apt/lists/*_*

# prepare build dir
RUN mkdir -p /build
WORKDIR /build/

# Download source code
RUN wget 'https://github.com/official-stockfish/Stockfish/archive/refs/tags/sf_15.1.tar.gz' && \
    tar -xf sf_15.1.tar.gz

# Build stockfish
RUN cd Stockfish-sf_15.1/src && \
    make help && \
    make net && \
    make build ARCH=x86-64-modern

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

COPY ./entrypoint.sh /

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales socat ucspi-tcp netcat procps && \
    apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /stockfish/
# USER stockfish:stockfish

COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/src/stockfish /stockfish/
COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/Copying.txt /stockfish/
# COPY --chown=nobody:root source.txt /stockfish/
COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/src/*.nnue /stockfish/
COPY entrypoint.sh /usr/local/bin/

USER nobody

EXPOSE 9010
CMD ["socat", "TCP-LISTEN:9010,reuseaddr,fork", "EXEC:/stockfish/stockfish"]
