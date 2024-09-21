#!/bin/bash
sudo ifconfig lo:ODU  "192.168.130.81"
sudo ifconfig lo:OAI_CU "192.168.130.83"

if [ ! -d "../O-CU" ]; then
    git clone -b OAI-CU-for-OSC https://github.com/dong881/openairinterface5g-NTUST.git ../O-CU
fi

if [ ! -d "../OAI_L1_UE" ]; then
    git clone -b OSC-use-nfapi https://github.com/dong881/openairinterface5g-NTUST.git ../OAI_L1_UE
fi

if [ ! -d "../O-DU" ]; then
    git clone -b FixRAR https://github.com/dong881/NTUST-OSC-DU-nFAPI.git ../O-DU
fi

sudo apt-get install moreutils -y
cd ./Tools
bash ./build-OAI-first
bash ./build-CU
bash ./build-OSC-all