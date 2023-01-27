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

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales socat ucspi-tcp netcat procps lsof nmap && \
    apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /stockfish/

COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/src/stockfish /stockfish/
COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/Copying.txt /stockfish/
COPY --chown=nobody:root --from=builder /build/Stockfish-sf_15.1/src/*.nnue /stockfish/

COPY ./entrypoint.sh /stockfish/
RUN chmod u+x /stockfish/entrypoint.sh

ENV STOCKFISH_PORT 9010

USER nobody

EXPOSE ${STOCKFISH_PORT}
CMD ["/stockfish/entrypoint.sh"]
#CMD ["socat", "TCP-LISTEN:${STOCKFISH_PORT},reuseaddr,fork", "EXEC:/stockfish/stockfish"]