#!/bin/bash

rm -r ../bot
mkdir ../bot

./copyTradingActor.sh
./botSettingsToConfigs.sh
