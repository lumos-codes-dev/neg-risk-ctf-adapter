#!/usr/bin/env bash

LOCAL=.env.local
TESTNET=.env.testnet
MAINNET=.env

if [ -z $1 ]
then
  echo "usage: deploy_wrapped_collateral.sh [local || testnet || mainnet]"
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
  echo "usage: deploy_wrapped_collateral.sh [local || testnet || mainnet]"
  exit 1
fi

source $ENV

DECIMALS=18

echo "Deploying WrappedCollateral..."

echo "Deploy args:
Underlying: $COLLATERAL
Decimals:   $DECIMALS
"

OUTPUT="$(forge script DeployWrappedCollateral \
    --private-key $PK \
    --rpc-url $RPC_URL \
    --json \
    --broadcast \
    --verify \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    -s "run(address,uint8)" "$COLLATERAL" "$DECIMALS")"

WRAPPED_COLLATERAL=$(echo "$OUTPUT" | grep -m1 "{" | jq -r .returns.wrappedCollateral.value)
echo "WrappedCollateral deployed: $WRAPPED_COLLATERAL"
