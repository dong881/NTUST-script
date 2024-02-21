sudo ifconfig lo: 127.0.0.2 netmask 255.0.0.0 up

# Common path
Target_PATH="/home/yen0224/NTUST/nfapi-fixes"
LOG_PATH="$Target_PATH/LTE-config/LOG"
OAI_PATH="$Target_PATH/openairinterface5g/cmake_targets"

# 進入目錄
cd "$OAI_PATH"

# 第一個腳本
# sudo ./build_oai -c --ninja --nrUE --gNB

# sudo ./build_oai --gNB --nrUE
# exit

cd "$OAI_PATH/ran_build/build"
pwd

sudo echo "Start TCPdump..."
sudo tcpdump -i any -nn -w $LOG_PATH/nFAPI_TCPdump_simple.pcap &

sudo echo "Start PNF..."
pnf_cmd="./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-LTE-EPC/CONF/oaiL1.nfapi.usrpx300.conf --nfapi PNF --rfsim --phy-test --rfsimulator.serveraddr server"
sudo stdbuf -oL $pnf_cmd 2>&1 | ts &> "$LOG_PATH/PNF-nfapi-fixes-simple.log" &

sudo echo "Start VNF..."
#  --nokrnmode 1
vnf_cmd="./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-LTE-EPC/CONF/rcc.band78.tm1.106PRB.nfapi.conf --nfapi VNF --noS1 --nokrnmode 1 --phy-test"
sudo stdbuf -oL $vnf_cmd 2>&1 | ts &> "$LOG_PATH/VNF-nfapi-fixes-simple.log" &

# sudo echo "Start UE..."
# ue_cmd="./nr-uesoftmodem --rfsim --phy-test -d --rfsimulator.serveraddr 127.0.0.1"
# sudo stdbuf -oL $ue_cmd 2>&1 | ts &> "$LOG_PATH/UE-nfapi-fixes-simple.log" &

wait_sec=25
echo "The script automatically closes after $wait_sec seconds..."
# Wait for the specified number of seconds
sleep $wait_sec

bash "$Target_PATH/exit"
echo "Time to $wait_sec seconds..."