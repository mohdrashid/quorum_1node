#!/bin/bash
set -u
set -e

if [ -d "data/keystore" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "Directory exists, Skipping initialization"
else
    echo "Initializing"
    ./initialization.sh
fi

sleep 2

mkdir -p $LOG_DIR
echo "[*] Starting Constellation nodes"
./constellation-start.sh

echo "Waiting for constellation to start"
sleep 3
echo "$(cat $DATA_DIR/geth/nodekey)"

echo "[*] Starting Ethereum nodes"
WEBSOCKET_ARGS="--ws --wsaddr 0.0.0.0"
ARGS="--raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --emitcheckpoints"
PRIVATE_CONFIG=./data/constellation/tm.ipc nohup geth --datadir $DATA_DIR $ARGS $WEBSOCKET_ARGS --wsorigins "*" --rpcport $RPC_PORT --wsport $WS_PORT --permissioned --raftport $RAFT_PORT --port $GETH_PORT 2>>$LOG_DIR/quorum.log 

echo "All node configured. Attaching to geth"

#geth attach data/geth.ipc