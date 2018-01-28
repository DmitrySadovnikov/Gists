geth --testnet --fast
cd Library/Ethereum/testnet/

geth —help

geth --networkid 3
geth --testnet (ROPSTEN)


geth --networkid 4
geth —rinkeby (RINKEBY)


geth —rinkeby —datadir “./data/rinkeby” —syncmode “light” —verbosity 4


// show config
geth dumpconfig

// backup default config
geth dumpconfig > /Users/d.sadovnikov/Desktop/repo/Gists/Blockchain/default.toml

// use different config
geth —rinkeby —datadir “./data/rinkeby” —syncmode “light” —verbosity 4 > test.toml
geth --config test.toml