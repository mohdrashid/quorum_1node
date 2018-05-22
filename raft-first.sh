#!/bin/bash
set -u
set -e

mkdir -p data/logs
echo "[*] Starting Constellation nodes"
./constellation-start.sh

echo "Waiting for constellation to start"
sleep 10

echo "[*] Starting Ethereum nodes"
set -v
WEBSOCKET_ARGS="--ws --wsaddr 0.0.0.0"
ARGS="--raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --emitcheckpoints"
PRIVATE_CONFIG=./data/constellation/tm.ipc nohup geth --datadir data $ARGS  $WEBSOCKET_ARGS --wsorigins "*" --wsport 8546 --permissioned --raftport 50401 --rpcport 22000 --port 21000 2>>data/logs/quorum.log &
set +v

echo
echo "All nodes configured. See 'data/logs' for logs, and run e.g. 'geth attach data/geth.ipc' to attach to the first Geth node."
echo "To test sending a private transaction from Node 1 to Node 7, run './runscript script1.js'"
