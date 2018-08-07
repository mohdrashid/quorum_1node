#!/bin/bash
set -u
set -e
othernode="http://127.0.0.1:9001/"
DDIR="data/constellation"

mkdir -p $DDIR
mkdir -p data/logs

cp "keys/node.pub" "$DDIR/node.pub"
cp "keys/node.key" "$DDIR/node.key"

rm -f "$DDIR/tm.ipc"
CMD="constellation-node --url=$othernode --port=9001 --workdir=$DDIR --socket=tm.ipc --publickeys=node.pub --privatekeys=node.key --othernodes=$othernode --tls=off"
echo "$CMD >> data/logs/constellation.log 2>&1 &"
$CMD >> "data/logs/constellation.log" 2>&1 &

DOWN=false

while $DOWN; do
    sleep 0.1
    DOWN=false
    if [ ! -S "data/constellation/tm.ipc" ]; then
        DOWN=true
    fi
done