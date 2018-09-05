#!/bin/bash
set -u
set -e

CONSTELLATION_DATA_DIR="$DATA_DIR/constellation"

echo "[*] Cleaning up temporary data directories"
rm -rf $DATA_DIR/*
rm -rf $CONSTELLATION_DATA_DIR/*
rm -rf $LOG_DIR/*

mkdir -p $DATA_DIR
mkdir -p $LOG_DIR
mkdir -p $CONSTELLATION_DATA_DIR

echo "Setting up Constellation keys"
mkdir keys && cd keys
yes ""| constellation-node --generatekeys=node
cp "node.pub" "../$CONSTELLATION_DATA_DIR/node.pub"
cp "node.key" "../$CONSTELLATION_DATA_DIR/node.key"
cd ..

echo "[*] Configuring node (permissioned)"
mkdir -p $DATA_DIR/{keystore,geth} &&
echo $NODE_KEY > $DATA_DIR/geth/nodekey &&
geth --datadir $DATA_DIR/ init $GENESIS_FILE