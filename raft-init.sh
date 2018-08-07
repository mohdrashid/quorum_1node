#!/bin/bash
set -u
set -e

echo "[*] Cleaning up temporary data directories"
rm -rf data/*
mkdir -p data/logs

echo "Setting up Constellation keys"
cd keys
yes ""| constellation-node --generatekeys=node
cd ..

echo "[*] Configuring node (permissioned)"
mkdir -p data/{keystore,geth} &&
cp permissioned-nodes.json data/static-nodes.json &&
cp permissioned-nodes.json data/ &&
cp nodekey/key data/geth/nodekey &&
geth --datadir data/ init genesis.json

echo
echo "Constellation Public Key: $(cat keys/node.pub)"