# Quorum 1 Node setup

## Installation of Quorum
1. Change username and versions as per requirement in setup.sh. Make sure to change username field to that of current user in linux.
2. Run `sudo ./setup.sh` . This will install the everything related to quorum.

## Setting up Quorum
1. Update nodekey located in nodekey folder, to differentiate nodes.
2. Add any existing permissioned nodes in permissioned-nodes.json 
3. Run istanbul-init.sh / raft-init.sh as per requirement. Make sure to change username field to that of current user in linux.

## Accessing the console
1. There will be no accounts available at this point.
2. To create an account, run geth client by typing the command `geth attach data/geth.ipc`. Once inside the console.