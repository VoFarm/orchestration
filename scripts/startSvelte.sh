#!/bin/bash

cd ../
git clone https://github.com/VoFarm/trading-actor-interface.git
cd trading-actor-interface && npm install && npx svelte build
