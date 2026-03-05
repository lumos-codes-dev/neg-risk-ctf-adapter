#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_neg_risk_fee_module.sh [local || testnet || mainnet]"
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
  echo "usage: deploy_neg_risk_fee_module.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

if [ -z "$NEG_RISK_ADAPTER" ]
then
  echo "Error: NEG_RISK_ADAPTER address must be set in $ENV"
  exit 1
fi

echo "Deploying NegRiskFeeModule..."

echo "Deploy args:
NegRiskCtfExchange: $NEG_RISK_CTF_EXCHANGE
NegRiskAdapter:     $NEG_RISK_ADAPTER
CTF:                $CTF
"

OUTPUT="$(forge script DeployNegRiskFeeModule \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run(address,address,address)" "$NEG_RISK_CTF_EXCHANGE" "$NEG_RISK_ADAPTER" "$CTF")"

NEG_RISK_FEE_MODULE=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.negRiskFeeModule.value)
echo "NegRiskFeeModule deployed: $NEG_RISK_FEE_MODULE"
