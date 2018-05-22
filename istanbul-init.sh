#!/bin/bash
set -u
set -e

user="username"

echo "[*] Cleaning up temporary data directories"
rm -rf data
mkdir -p data/logs

echo "Setting up Constellation keys"
cd keys
constellation-node --generatekeys=node
sudo chown $user:$user node.*
cd ..

echo "[*] Configuring node 4 as voter"
mkdir -p data/{keystore,geth}
cp permissioned-nodes.json data/static-nodes.json
cp permissioned-nodes.json data/
cp nodekey/key data/geth/nodekey
geth --datadir data init istanbul-genesis.json
