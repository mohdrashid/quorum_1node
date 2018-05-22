#!/bin/bash
set -u
set -e

mkdir -p data/logs
echo "[*] Starting Constellation nodes"
./constellation-start.sh

echo "Waiting for constellation to start"
sleep 3

echo "[*] Starting Ethereum nodes"
set -v
WEBSOCKET_ARGS="--ws --wsaddr 0.0.0.0"
ARGS="--syncmode full --mine --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul"
PRIVATE_CONFIG=data/constellation/tm.ipc nohup geth --datadir data $ARGS $WEBSOCKET_ARGS --wsorigins "*" --wsport 8546 --rpcport 22000 --port 21000 --istanbul.blockperiod 1 2>>data/logs/quorum.log &
set +v

echo
echo "All nodes configured. See 'data/logs' for logs, and run e.g. 'geth attach qdata/dd1/geth.ipc' to attach to the first Geth node."
