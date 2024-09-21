#!/bin/bash
source ./VARIABLE.sh

# sudo ifconfig lo:ODU  "192.168.130.81"
# sudo ifconfig lo:OAI_CU "192.168.130.83"

# git clone -b OAI-CU-for-OSC https://github.com/dong881/openairinterface5g-NTUST.git ../O-CU
# git clone -b OSC-use-nfapi https://github.com/dong881/openairinterface5g-NTUST.git ../OAI_L1_UE
# git clone -b FixRAR https://github.com/dong881/NTUST-OSC-DU-nFAPI.git ../O-DU

# sudo apt-get install moreutils -y
# cd $PATH_TO_L1_UE/cmake_targets
# sudo ./build_oai -c --ninja --nrUE --gNB -I
bash ./Tools/build-CU
bash ./Tools/build-OSC-all