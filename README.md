# Setup Instructions

Currently, raft is the only consensus mechanism supported in this docker version. Istanbul consensus will be added shortly.

## 1. Clone the repository
Clone the repository by typing `git clone https://github.com/mohdrashid/docker_quorum.git` in the terminal.
After that go the downloaded repository by typing `cd docker_quorum`

## 2. Edit the variables
If required you can edit the ports or other informations by changing the corresponding value in environment.env file

## 3. Map the data and log directories
Go to volume section of docker-compose.yml file and make sure volumes are mapped to your desired directories.

## 4. Build the image
Type `docker-compose build` to build the images by pulling all requirements and to perform quorum related installations

## 5. Run image
Type `docker-compose up` to bring up the image and start the quorum node

## 6. Interacting with node
You can easily interact with the node by typing `geth attach PATH_TO_DATA/dd1/geth.ipc` this will bring up the console. This step will require you to install geth. In ubuntu this can be done by typing `sudo apt-get install geth`

# Regarding your keys
Your constellation public ID can be obtained from data directory in constellation/node.pub file. This will be used by others to send you private transaction. Ethereum accounts can be added from geth using standard geth commands.

# 3 Node setup
To use the 3 Node setup in docker switch the branch to 3nodes