#!/bin/bash

countMain=0

function finish {
  for pid in ${pids[*]}; do
    kill "$pid"
  done
}
trap finish EXIT
trap finish TSTP
trap finish CONT

./build.sh
sudo ./startNginx.sh

./startAllBots.sh &
pids[${countMain}]=$!
((countMain++))

./startSvelte.sh &
pids[${countMain}]=$!
((countMain++))

for pid in ${pids[*]}; do
  wait "$pid"
done
