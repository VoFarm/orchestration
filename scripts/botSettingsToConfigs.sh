#!/bin/bash

function generateNGINXConfig {
  echo "location /$1/ {
                proxy_pass http://localhost:$2/;
          }"
}

DIRENV=../bot/env
DIRCONFIGS=../nginx/configs

rm -fr $DIRENV
rm -fr $DIRCONFIGS

mkdir $DIRENV
mkdir $DIRCONFIGS

for s in $(cat ../bots.json | jq -c '.[]'); do
  CONTRACTADDRESS=$(echo $s | jq -cr '.tradingActorContractAddress')
  HTTPPort=$(echo $s | jq -cr '.HTTPPort')

  echo $(generateNGINXConfig "$CONTRACTADDRESS" "$HTTPPort") >>$DIRCONFIGS/"$CONTRACTADDRESS.conf"
  for z in $(echo $s | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]"); do
    echo $z >>$DIRENV/"$CONTRACTADDRESS"
  done
done
