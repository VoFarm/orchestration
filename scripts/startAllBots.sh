#!/bin/bash

count=0

function finish {
  for pid in ${pids[*]}; do
    kill "$pid"
  done
  killall "../bot/trading-actor-binary"
}
trap finish EXIT
trap finish TSTP
trap finish CONT

for file in ../bot/env/*; do
  bash -ac "while true; do
  source ${file} && ./../bot/trading-actor-binary
  sleep 60
  done" &
  pids[${count}]=$!
  ((count++))
done

for pid in ${pids[*]}; do
  wait "$pid"
done
