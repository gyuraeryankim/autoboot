#!/bin/bash    
killall nodeos

#unlock wallet with the keys inside
#update walletpassword.txt for the new wallet!
#KEYS
#eosio pub: EOS5kiTBoD38FxXTmcPzJS3EjtcusKE2WkEfjGEPFTnnth21hQMHa
#eosio priv: 5KX9iLDRus4jevcBRPArmPRrkQFD9MBtTEdjAxnYMR5a9wcs46W
#ryangenesis1 (first bp) pub: EOS8KdvkTPgvRHfW5zzTx8UsZaHeYycqgxyvC7Q6eHbqK8LijVQro
#ryangenesis2 priv: 5Jp4CoW2tNQ8TtZeLJoZjtaT7RF4oa9NUGPP1Hj6Dp1UnFDoWgp 

#unlock wallet
./cleos.sh wallet unlock < ./walletpassword.txt &> /dev/null

#run eosio node. see datadir for logs
nodeos -e -p eosio --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin --signature-provider=EOS5kiTBoD38FxXTmcPzJS3EjtcusKE2WkEfjGEPFTnnth21hQMHa=KEY:5KX9iLDRus4jevcBRPArmPRrkQFD9MBtTEdjAxnYMR5a9wcs46W --genesis-json /home/eos/ibctprivate/genesis.json --delete-all-blocks > /home/eos/ibctprivate/stdout.txt 2> /home/eos/ibctprivate/stderr.txt & echo $! > /home/eos/ibctprivate/nodoes.pid

#give time for the node to be initialized.
sleep 2s

#run booting sequences. sleep 1s between each sript for actions to get propagated
./02*
sleep 1s
./03*
sleep 1s
./04*
sleep 1s
./05*
sleep 1s
./06*
sleep 1s
./07*

#run ryangenesis1 node. see /home/eos/ibct_bios/starting_node_config.ini for configurations.
/home/eos/ibctprivate/node1/start.sh
#give time for the node to be initialized
sleep 2s

./cleos.sh system regproducer ryangenesis1 EOS8KdvkTPgvRHfW5zzTx8UsZaHeYycqgxyvC7Q6eHbqK8LijVQro "ibctmini.io" -p ryangenesis1
sleep 1s
./cleos.sh system delegatebw ryangenesis1 ryangenesis1  "1000000.0000 CR" "1000000.0000 CR"
sleep 1s
./cleos.sh system voteproducer prods eosio ryangenesis1
sleep 3s
./cleos.sh get info
sleep 1.5s
# at this point you will see ryangensis1 as a head block producer

#resign now
./08*

#now manually shutdown eosio nodeos
