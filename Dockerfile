FROM ubuntu:latest
# Get the Ethereum Stuffs
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y build-essential git
RUN add-apt-repository ppa:longsleep/golang-backports
RUN apt-get update
RUN apt-get install -y golang-go
RUN git clone https://github.com/ethereum/go-ethereum
WORKDIR /go-ethereum
RUN make geth
WORKDIR /
# House the data here
RUN mkdir /block-data
# Pass in the genesis block. 
COPY GenesisBlock.json GenesisBlock.json
COPY blockchain.sh blockchain.sh
RUN ln -sf /go-ethereum/build/bin/geth /bin/geth
EXPOSE 22 8088 50070 8545
ENTRYPOINT geth --datadir /block-data init /GenesisBlock.json; geth --port 3000 --networkid 58342 --nodiscover --datadir=./block-data --maxpeers=0  --rpc  --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,miner"