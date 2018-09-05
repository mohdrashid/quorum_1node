#!/bin/bash
set -u
set -e

constellation-node --version

echo "Setting up Constellation keys"
if [ ! -d "data" ]; then
    echo "Creating directory"
    mkdir data
fi

if [ -f "data/node.pub" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "Directory exists, Skipping initialization"
else
    echo "Initializing"
    yes ""| constellation-node --generatekeys=node
    cp "node.pub" "data/node.pub"
    cp "node.key" "data/node.key"
    cd ..
fi

rm -f "data/tm.ipc"
CMD="constellation-node --url=$CONSTELLATION_ADDRESS --port=$CONSTELLATION_PORT --workdir=data --socket=tm.ipc --publickeys=node.pub --privatekeys=node.key --othernodes=$OTHER_CONSTELLATION_NODES --tls=off"
$CMD >> "data/info.log" 2>&1 &

DOWN=false

while $DOWN; do
    sleep 0.1
    DOWN=false
    if [ ! -S "data/tm.ipc" ]; then
        DOWN=true
    fi
done

echo "Constellation is UP"
ls
tail -f data/info.log