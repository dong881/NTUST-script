# README

This repository contains scripts for configuring and running O-RAN OSC (Open Source Core) components, specifically the OSC DU (Distributed Unit) and associated components. The scripts provided are targeted for specific network functions, including CU_STUB, RIC_STUB, ODU (OSC DU), and PNF (Physical Network Function). 

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
