#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_vault.sh [local || testnet || mainnet]"
  exit 1
elif [ $1 == "local" ]
then
  ENV=$LOCAL
elif [ $1 == "testnet" ]
then
  ENV=$TESTNET
elif [ $1 == "mainnet" ]
then
  ENV=$MAINNET
else
  echo "usage: deploy_vault.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

echo "Deploying Vault..."

OUTPUT="$(forge script DeployVault \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run()")"

VAULT=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.vault.value)
echo "Vault deployed: $VAULT"
