FROM ubuntu:16.04 as builder

# install add repository
RUN apt-get update && apt-get install software-properties-common -y 

# install build deps
RUN add-apt-repository ppa:ethereum/ethereum &&\
    apt-get update &&\
    apt-get install -y build-essential wget unzip git libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc wrk

# install constellation
ARG CVER="0.3.2"
ARG CREL="constellation-$CVER-ubuntu1604"

RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v$CVER/$CREL.tar.xz && \
    tar xfJ $CREL.tar.xz && \
    cp $CREL/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node && \
    rm -rf $CREL

# install golang
ARG GOREL="go1.9.3.linux-amd64.tar.gz"
RUN wget -q https://dl.google.com/go/$GOREL && \
    tar xfz $GOREL && \
    mv go /usr/local/go && \
    rm -f $GOREL

ENV PATH $PATH:/usr/local/go/bin

# make/install quorum
ARG QVER="v2.0.2"
RUN git clone https://github.com/jpmorganchase/quorum.git && \
    cd quorum && \
    git checkout tags/$QVER && \
    make all && \
    cp build/bin/geth /usr/local/bin && \
    cp build/bin/bootnode /usr/local/bin && \
    cd .. && \
    rm -rf quorum && \
    rm *.xz && \
    echo "Done installing quorum"

WORKDIR /quorum

COPY . .

#JSON RPC
EXPOSE 8545
#ETH
EXPOSE 21000
#RAFT
EXPOSE 50401
#WS
EXPOSE 8546
#Constellation
EXPOSE 9001
EXPOSE 9003

#RUN ./raft-init.sh

ENTRYPOINT ["./raft-start.sh"]