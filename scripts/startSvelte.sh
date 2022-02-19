#!/bin/bash

function finish {
  kill "0"
}
trap finish EXIT
trap finish TSTP
trap finish CONT

cd ../ui
snel serve &
pids[0]=$!

for pid in ${pids[*]}; do
  wait "$pid"
done
