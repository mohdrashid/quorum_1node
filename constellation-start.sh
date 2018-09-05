#!/bin/bash
set -u
set -e

constellation-node --version

echo "Setting up Constellation keys"
if [ -d "data" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "Directory exists, Skipping initialization"
else
    echo "Initializing"
    mkdir data
    yes ""| constellation-node --generatekeys=node
    cp "node.pub" "data/node.pub"
    cp "node.key" "data/node.key"
    cd ..
fi

rm -f "data/tm.ipc"
CMD="constellation-node --url=$CONSTELLATION_ADDRESS --port=$CONSTELLATION_PORT --workdir=data --socket=data/tm.ipc --publickeys=node.pub --privatekeys=node.key --othernodes=$OTHER_CONSTELLATION_NODES --tls=off"
$CMD >> "data/info.log" 2>&1 &

DOWN=false

while $DOWN; do
    sleep 0.1
    DOWN=false
    if [ ! -S "tm.ipc" ]; then
        DOWN=true
    fi
done

echo "Constellation is UP"

tail -f data/info.log