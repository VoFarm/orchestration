#!/bin/bash

function generateNGINXConfig {
  echo "location /$1/ { proxy_pass http://$2:$3/; }"
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
  URL=$(echo "$s" | jq -cr '.url')
  HTTPPort=$(echo "$s" | jq -cr '.HTTPPort')

  echo $(generateNGINXConfig "$CONTRACTADDRESS" "$URL" "$HTTPPort") >>$DIRCONFIGS/"$CONTRACTADDRESS.conf"
  for z in $(echo "$s" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]"); do
    echo "$z" >>$DIRENV/"$CONTRACTADDRESS"
  done
done

echo $(generateNGINXContractList "${CONTRACTLIST::-1}") >>$DIRCONFIGS/contractList.conf
