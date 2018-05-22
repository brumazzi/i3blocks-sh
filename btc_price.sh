#!/bin/sh

COUNT=$(curl --request GET  https://api.coinmarketcap.com/v1/ticker/bitcoin/)
COUNT=$(echo $COUNT | jq .[].price_usd)
echo ${COUNT//'"'/' '}
