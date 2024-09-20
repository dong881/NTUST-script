#!/bin/bash
source ./VARIABLE.sh

sudo apt-get install moreutils -y
cd $PATH_TO_L1_RFSIM_UE/cmake_targets
sudo ./build_oai -c --ninja --nrUE --gNB -I