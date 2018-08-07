#!/bin/bash
set -u
set -e

if [ -d "data/keystore" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "Directory exists, Skipping initialization"
else
    ./raft-init.sh
fi

sleep 5

mkdir -p data/logs
echo "[*] Starting Constellation nodes"
./constellation-start.sh

echo "Waiting for constellation to start"
sleep 5
echo "$(cat data/geth/nodekey)"

echo "[*] Starting Ethereum nodes"
WEBSOCKET_ARGS="--ws --wsaddr 0.0.0.0"
ARGS="--raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --emitcheckpoints"
PRIVATE_CONFIG=./data/constellation/tm.ipc nohup geth console --datadir data $ARGS  $WEBSOCKET_ARGS --wsorigins "*" --rpcport 8545 --wsport 8546 --permissioned --raftport 50401 --port 21000 2>>data/logs/quorum.log 
echo
echo "All nodes configured. See 'data/logs' for logs, and run e.g. 'geth attach data/geth.ipc' to attach to the first Geth node."