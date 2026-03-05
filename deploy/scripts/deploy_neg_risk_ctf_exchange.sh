#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_neg_risk_ctf_exchange.sh [local || testnet || mainnet]"
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
  echo "usage: deploy_neg_risk_ctf_exchange.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

if [ -z "$NEG_RISK_ADAPTER" ]
then
  echo "Error: NEG_RISK_ADAPTER address must be set in $ENV"
  exit 1
fi

if [ -z "$PROXY_FACTORY" ]
then
  echo "Error: PROXY_FACTORY address must be set in $ENV"
  exit 1
fi

if [ -z "$SAFE_FACTORY" ]
then
  echo "Error: SAFE_FACTORY address must be set in $ENV"
  exit 1
fi

echo "Deploying NegRiskCtfExchange..."

echo "Deploy args:
Collateral:       $COLLATERAL
CTF:              $CTF
NegRiskAdapter:   $NEG_RISK_ADAPTER
ProxyFactory:     $PROXY_FACTORY
SafeFactory:      $SAFE_FACTORY
"

OUTPUT="$(forge script DeployNegRiskCtfExchange \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run(address,address,address,address,address)" "$COLLATERAL" "$CTF" "$NEG_RISK_ADAPTER" "$PROXY_FACTORY" "$SAFE_FACTORY")"

NEG_RISK_CTF_EXCHANGE=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.negRiskCtfExchange.value)
echo "NegRiskCtfExchange deployed: $NEG_RISK_CTF_EXCHANGE"
