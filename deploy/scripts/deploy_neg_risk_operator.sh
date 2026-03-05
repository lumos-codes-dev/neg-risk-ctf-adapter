#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_neg_risk_operator.sh [local || testnet || mainnet]"
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
  echo "usage: deploy_neg_risk_operator.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

if [ -z "$NEG_RISK_ADAPTER" ]
then
  echo "Error: NEG_RISK_ADAPTER address must be set in $ENV"
  exit 1
fi

echo "Deploying NegRiskOperator..."

echo "Deploy args:
NegRiskAdapter: $NEG_RISK_ADAPTER
"

OUTPUT="$(forge script DeployNegRiskOperator \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run(address)" "$NEG_RISK_ADAPTER")"

NEG_RISK_OPERATOR=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.negRiskOperator.value)
echo "NegRiskOperator deployed: $NEG_RISK_OPERATOR"
