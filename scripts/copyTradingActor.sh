#!/bin/bash

NEWESTVERSION=$(curl --silent "https://github.com/VoFarm/web3-trading-actor/releases/latest" | grep -Po 'href="([\w\W]*)"' | cut -d= -f2 | sed "s/tag/download/" | sed "s/\"//g")
wget "${NEWESTVERSION}/trading-actor.zip"

unzip -d ../bot/ trading-actor.zip

rm trading-actor.zip
