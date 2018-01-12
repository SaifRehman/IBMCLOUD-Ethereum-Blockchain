#!/bin/bash
geth --datadir /block-data init /GenesisBlock.json 
geth --port 3000 --networkid 58342 --nodiscover --datadir=./block-data --maxpeers=0  --rpc --rpcport 8545 --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,miner"
