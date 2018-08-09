#!/bin/bash
set -u
set -e

echo "[*] Cleaning up temporary data directories"
rm -rf $DATA_DIR/*
mkdir -p $LOG_DIR

echo "Setting up Constellation keys"
cd keys
yes ""| constellation-node --generatekeys=node
cd ..

echo "[*] Configuring node (permissioned)"
mkdir -p $DATA_DIR/{keystore,geth} &&
cp permissioned-nodes.json $DATA_DIR/static-nodes.json &&
cp permissioned-nodes.json $DATA_DIR/ &&
cp nodekey/key $DATA_DIR/geth/nodekey &&
geth --datadir $DATA_DIR/ init genesis.json

echo
echo "Constellation Public Key: $(cat keys/node.pub)"