# Quorum 1 Node setup

## 1. Installation of Quorum
1. Change username and versions as per requirement in setup.sh. Make sure to change username field to that of current user in linux.
2. Run `sudo ./setup.sh` . This will install the everything related to quorum.

## 2. Setting up Quorum
1. Update nodekey located in nodekey folder, to differentiate nodes.
2. Add any existing permissioned nodes in permissioned-nodes.json 
3. Run raft-init.sh by typing `./raft-init.sh` . Make sure to change username field to that of current user in linux.
4. This will prompt you type an optional password for constellation key. If you type any password, the constellation-start.sh file needs to modified to accomate the password.

##3.1  Running Quorum without unlocked account
1. There will be no accounts available at this point.
2. So start RAFT by running `./raft-start.sh` 
3. After that get access to geth console by typing `geth attach data/geth.ipc`
4. Once in the console, type `personal.newAccount()` to create a new account in geth. This will prompt you for to enter a password.
5. Use the command `./raft-start.sh` to start the node from now on

##3.2  Running Quorum with unlocked account
1. If you require the account to be unlocked, follow steps in 3.1
2. Once you complete that, enter the password you entered in account creation in geth to the file `password.txt`
3. Type './stop.sh' to halt all quorum processes.
4. Type './raft-start-unlocked.sh' to start the geth with account unlocked.