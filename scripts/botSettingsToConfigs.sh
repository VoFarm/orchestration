#!/bin/bash

function generateNGINXConfig {
  echo "location /$1/ { proxy_pass http://localhost:$2/; }"
}

function generateNGINXContractList {
  echo "location /contractList { return 200 \"$1\"; }"
}

DIRENV=../bot/env
DIRCONFIGS=../nginx/configs

rm -fr $DIRENV
rm -fr $DIRCONFIGS

mkdir $DIRENV
mkdir $DIRCONFIGS

CONTRACTLIST=""

for s in $(jq -c '.[]' <../bots.json); do
  CONTRACTADDRESS=$(echo "$s" | jq -cr '.tradingActorContractAddress')
  CONTRACTLIST="$CONTRACTADDRESS,$CONTRACTLIST"
  HTTPPort=$(echo "$s" | jq -cr '.HTTPPort')

  echo $(generateNGINXConfig "$CONTRACTADDRESS" "$HTTPPort") >>$DIRCONFIGS/"$CONTRACTADDRESS.conf"
  for z in $(echo "$s" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]"); do
    echo "$z" >>$DIRENV/"$CONTRACTADDRESS"
  done
done

echo $(generateNGINXContractList "${CONTRACTLIST::-1}") >>$DIRCONFIGS/contractList.conf
