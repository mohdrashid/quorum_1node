ARG CVER="0.3.2"
ARG GOREL="go1.9.3.linux-amd64.tar.gz"
ARG QVER="v2.0.2"

FROM ubuntu:16.04 as builder

RUN apt-get update

# We need a PPA for libsodium on trusty:
RUN bash -c 'if [ "$(lsb_release -sc)" == "trusty" ]; then \
               apt-get install -y software-properties-common && \
               add-apt-repository ppa:chris-lea/libsodium && \
               apt-get update; \
             fi'

RUN apt-get install -y libgmp-dev libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev && \
    apt-get install -y ruby ruby-dev build-essential && \
    gem install --no-ri --no-rdoc fpm

WORKDIR /constellation

#Constellation
EXPOSE ${CONSTELLATION_PORT}

ENTRYPOINT ["./constellation-start.sh"]