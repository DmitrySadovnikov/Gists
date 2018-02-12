geth --testnet --fast
cd Library/Ethereum/testnet/

geth --help

geth --networkid 3
geth --testnet (ROPSTEN)


geth --networkid 4
geth --rinkeby (RINKEBY)


geth --rinkeby --datadir "./data/rinkeby" --syncmode "light" --verbosity 4


// show config
geth dumpconfig

// backup default config
geth dumpconfig > /Users/d.sadovnikov/Desktop/repo/Gists/Blockchain/default.toml

// use different config
geth —-rinkeby —-datadir "./data/rinkeby" —-syncmode "light" dumpconfig > test.toml
geth --config test.toml


// run localhost
geth --rpc --rpcaddr "localhost" --rpcport "8545" --identity "MyTestNode" --datadir "./data" --trace "./trace"

// console
geth --verbosity "0" --identity "MyTestNode" --datadir "./data" --testnet --fast console

// preload own functions
geth --preload "./scripts/utils.js" console

// create account
geth --datadir "./data" --testnet account new


//// JS API ////

personal.newAccount('pass')
personal.listAccounts()
personal.importRawKey(keydata, paraphrase)
personal.unlockAccount()
personal.lockAccount()
personal.sendTransaction(txn_obj, 'paraphrase')

txn_obj = {
    from: '0x123',
    to: '0x456',
    value: '1' (in Wei) // or web3.toWei(1)
}
...

geth CLI --unlock option

// Transactions info
txpool.inspect
txpool.content
txpool.status

// debug

debug.verbosity(level)
debug.dumpBlock(number)
debug.traceBlockByNumber(number)
debug.traceBlockByHash(hash)
debug.traceTransaction(xHash)



////////