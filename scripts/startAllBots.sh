#!/bin/bash

count=0

function finish {
  for pid in ${pids[*]}; do
    kill "$pid"
  done
}
trap finish EXIT
trap finish TSTP
trap finish CONT

for file in ../bot/env/*; do
  bash -ac "while true; do
  source ${file} && ./../bot/main
  sleep 15
  done" &
  pids[${count}]=$!
  ((count++))
done

for pid in ${pids[*]}; do
  wait "$pid"
done
