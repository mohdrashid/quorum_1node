#!/bin/bash
set -u
set -e

CONSTELLATION_DATA_DIR="$DATA_DIR/constellation"
mkdir -p $CONSTELLATION_DATA_DIR
mkdir -p $LOG_DIR

cp "keys/node.pub" "$CONSTELLATION_DATA_DIR/node.pub"
cp "keys/node.key" "$CONSTELLATION_DATA_DIR/node.key"

rm -f "$CONSTELLATION_DATA_DIR/tm.ipc"
CMD="constellation-node --url=$CONSTELLATION_ADDRESS --port=$CONSTELLATION_PORT --workdir=$CONSTELLATION_DATA_DIR --socket=tm.ipc --publickeys=node.pub --privatekeys=node.key --othernodes=$OTHER_CONSTELLATION_NODES --tls=off"
echo "$CMD >> $LOG_DIR/constellation.log 2>&1 &"
$CMD >> "$LOG_DIR/constellation.log" 2>&1 &

DOWN=false

while $DOWN; do
    sleep 0.1
    DOWN=false
    if [ ! -S "$CONSTELLATION_DATA_DIR/tm.ipc" ]; then
        DOWN=true
    fi
done