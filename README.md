# ibctautoboot

nodeos -e -p eosio --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin --signature-provider=EOS5kiTBoD38FxXTmcPzJS3EjtcusKE2WkEfjGEPFTnnth21hQMHa=KEY:5KX9iLDRus4jevcBRPArmPRrkQFD9MBtTEdjAxnYMR5a9wcs46W --genesis-json /home/eos/ibctprivate/genesis.json

run 1-7

./start.sh

./cleos.sh system regproducer ryangenesis1 EOS8KdvkTPgvRHfW5zzTx8UsZaHeYycqgxyvC7Q6eHbqK8LijVQro "ibctmini.io" -p ryangenesis1

./cleos.sh system delegatebw ryangenesis1 ryangenesis1  "1000000.0000 CR" "1000000.0000 CR"

./cleos.sh system voteproducer prods eosio ryangenesis1

./cleos.sh get info

run 8

shutdown eosio node
