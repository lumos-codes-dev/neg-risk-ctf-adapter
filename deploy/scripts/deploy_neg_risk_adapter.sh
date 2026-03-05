#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_neg_risk_adapter.sh [local || testnet || mainnet]"
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
  echo "usage: deploy_neg_risk_adapter.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

if [ -z "$VAULT" ]
then
  echo "Error: VAULT address must be set in $ENV"
  exit 1
fi

echo "Deploying NegRiskAdapter..."

echo "Deploy args:
CTF:        $CTF
Collateral: $COLLATERAL
Vault:      $VAULT
"

OUTPUT="$(forge script DeployNegRiskAdapter \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run(address,address,address)" "$CTF" "$COLLATERAL" "$VAULT")"

NEG_RISK_ADAPTER=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.negRiskAdapter.value)
echo "NegRiskAdapter deployed: $NEG_RISK_ADAPTER"
