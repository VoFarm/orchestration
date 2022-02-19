#!/bin/bash

function finish {
  kill "0"
}
trap finish EXIT
trap finish TSTP
trap finish CONT

cd ../
git clone https://github.com/VoFarm/trading-actor-interface.git
cd trading-actor-interface
snel serve &
pids[0]=$!

for pid in ${pids[*]}; do
  wait "$pid"
done
