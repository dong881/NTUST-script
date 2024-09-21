# README

This repository contains scripts for configuring and running O-RAN OSC (Open Source Core) components, specifically the OSC DU (Distributed Unit) and associated components. The scripts provided are targeted for specific network functions, including CU_STUB, RIC_STUB, ODU (OSC DU), and PNF (Physical Network Function). 


# How to start (By-youself)
## Prerequisites
### OAI CU
```bash
git clone -b OAI-CU-for-OSC https://github.com/dong881/openairinterface5g-NTUST.git CU
# Build
cd ~/bmwlab_tony_cu_du/oai_cu/cmake_targets
./build_oai --gNB --nrUE -w SIMU

# sync up the format of F1AP
./f1ap_codec_mod.sh

# compile the part of RAN
cd ~/bmwlab_tony_cu_du/oai_cu/cmake_targets
./build_oai --gNB
```

### OSC DU
```bash
git clone https://github.com/Richard-yq/o-du-l2
git checkout oai_nFAPI
cd o-du-l2/build/odu
#clean
make clean_ric MACHINE=BIT64 MODE=TDD NFAPI=YES
make clean_odu MACHINE=BIT64 MODE=TDD NFAPI=YES

#compile
make ric_stub NODE=TEST_STUB MACHINE=BIT64 MODE=TDD NFAPI=YES
make odu MACHINE=BIT64 MODE=TDD NFAPI=YES
```

### OAI PNF &RFsim &UEsim
```bash
git clone https://github.com/dong881/openairinterface5g-NTUST.git
git checkout OSC-use-nfapi
cd ~/openairinterface5g/cmake_targets

# compile for first time
./build_oai -I -c -C
sudo ./build_oai -c --ninja --nrUE --gNB

# compile with ninja
sudo ninja nr-softmodem nr-uesoftmodem dfts ldpc params_libconfig rfsimulator
```

So far, you should have prepared three folders: one for OAI CU (bmwlab_tony_cu_du), one for OSC (o-du-l2), and one for OAI PNF+UEsim (openairinterface5g). Once you have ensured that all of them are successfully compiled, you can proceed to the next step and start executing.

- bmwlab_tony_cu_du
- o-du-l2
- openairinterface5g

## Execute
### OAI CU
```bash
cd ~/bmwlab_tony_cu_du/oai_cu/cmake_targets/ran_build/build
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/cu_fdd_gnb.sa.band66.fr1.106PRB.usrpb210.conf --sa
```
### OSC RIC Stub
```bash
cd ~/o-du-l2/bin/ric_stub
sudo ./ric_stub
```
### OSC DU
```bash
cd ~/o-du-l2/bin/odu
sudo ./odu
```
### OAI PNF &Rfsim
```bash
cd ~/openairinterface5g/cmake_targets/ran_build/build
sudo ./nr-softmodem -O ./ELSE/oaiL1.nfapi.usrpb210.conf --nfapi PNF --rfsim --rfsimulator.serveraddr server --sa

```
### OAI UEsim
```bash
cd ~/openairinterface5g/cmake_targets/ran_build/build
sudo ./nr-uesoftmodem -r 106 --numerology 1 --band 78 -C 3619200000 --sa --uicc0.imsi 001010000000001 --rfsim
```

## Prerequisites for oneclick script
Before using these scripts, make sure that the necessary dependencies and libraries are already installed on your system. Additionally, ensure that the path configurations in the scripts are correctly set according to your environment.

```bash
sudo apt-get update
# for timestamp log
sudo apt-get install moreutils

sudo ./build_oai -I
```

### File Structure
The file structure of this repository is as follows:

- **0:** This script is responsible for assigning IP addresses and starting OSC DU, CU_STUB, RIC_STUB, and OAI PNF processes.

- **nfapi-fixes/all-in-one:** This script configures and runs OAI components using the nfapi-fixes. It includes the build process for OAI components and starts the PNF and VNF processes.

### Usage
To use the scripts in this repository, follow the instructions below:

1. **0 script:**
    - Execute the script using `./0`.
    - This script assigns IP addresses and starts OSC DU, CU_STUB, RIC_STUB, and OAI PNF processes.

2. **nfapi-fixes/all-in-one script:**
    - Execute the script using `./nfapi-fixes/all-in-one`.
    - The script builds OAI components, starts PNF and VNF processes, and automatically closes after 3 seconds.
    - You need to git clone OAI (branch: nfapi-fixes)
   ```bash
   git clone -b nfapi-fixes https://gitlab.eurecom.fr/oai/openairinterface5g.git ./NTUST-script/nfapi-fixes/openairinterface5g
   ```

### Important Notes
Please take note of the following important points:

- Ensure that the system has the necessary permissions to execute the scripts.
- Verify that all required dependencies are installed before running the scripts.
- Customize IP addresses and paths in the scripts based on your network configuration.

### Disclaimer
These scripts are provided as-is and may require adjustments based on your specific environment and configurations. Use them at your own risk. The authors are not responsible for any issues or damages resulting from the use of these scripts.

Feel free to contribute, report issues, or provide feedback to enhance the functionality of these scripts.



# Automatic Build and Execution Tool for OSC DU, OAI Layer1, and OAI UEsim

This tool automates the building and execution of OSC DU, OAI Layer1, and OAI UEsim components. It simplifies the process by allowing users to execute these components in the background without manual intervention. Upon reaching a predetermined timeout, the tool gracefully terminates itself. Additionally, it ensures that all logs and TCPdump outputs are timestamped and automatically saved in the designated folder.

## Usage

1. Ensure all necessary configurations are set up correctly.
2. Execute the main executable file located at `0`.
3. Monitor the logs in the `LOG` folder for any errors or updates.
4. Upon completion or timeout, review the generated logs and TCPdump outputs in the designated folder.

## Notes

- The tool automatically builds OSC DU, OAI Layer1, and OAI UEsim components.
- It executes these components in the background.
- Upon reaching a predetermined timeout, the tool gracefully terminates itself.
- All logs and TCPdump outputs are timestamped and automatically saved in the designated folder.

For detailed instructions and troubleshooting, refer to the respective documentation or contact me.

## Prerequisites
- The scripts assume that the necessary dependencies and libraries are already installed on the system.
- Ensure the correct path configurations in the scripts according to your environment.

```bash
sudo apt-get update
# for timestamp log
sudo apt-get install moreutils

sudo ./build_oai -I
```

## File Structure
- **0:** This script is responsible for assigning IP addresses and starting OSC DU, CU_STUB, RIC_STUB, and OAI PNF processes.

- **nfapi-fixes/all-in-one:** This script configures and runs OAI (Open Air Interface) components using the nfapi-fixes. It includes the build process for OAI components and starts the PNF and VNF processes.

## Usage

1. **0 script:**
    - Execute the script using `./0`.
    - This script assigns IP addresses and starts OSC DU, CU_STUB, RIC_STUB, and OAI PNF processes.

2. **nfapi-fixes/all-in-one script:**
    - Execute the script using `./nfapi-fixes/all-in-one`.
    - The script builds OAI components, starts PNF and VNF processes, and automatically closes after 3 seconds.
    - You need to git clone OAI (branch: nfapi-fixes)
   ```bash
   git clone -b nfapi-fixes https://gitlab.eurecom.fr/oai/openairinterface5g.git ./NTUST-script/nfapi-fixes/openairinterface5g
   ```

## Important Notes
- Ensure that the system has the necessary permissions to execute the scripts.
- Verify that all required dependencies are installed before running the scripts.
- Customize IP addresses and paths in the scripts based on your network configuration.

## Disclaimer
These scripts are provided as-is and may need adjustments based on your specific environment and configurations. Use them at your own risk. The authors are not responsible for any issues or damages resulting from the use of these scripts.

Feel free to contribute, report issues, or provide feedback to enhance the functionality of these scripts.
