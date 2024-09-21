# README

This repository contains scripts for configuring and running O-RAN OSC (Open Source Core) components, specifically the OSC DU (Distributed Unit) and associated components. The scripts provided are targeted for specific network functions, including CU_STUB, RIC_STUB, ODU (OSC DU), and PNF (Physical Network Function). 

# How to start (One-click)
## Execute install script
```bash
cd NTUST-script
./First-time-execute-me.sh
```

## Start!
No additional actions are required. Once the installation is complete and no errors are found, simply execute the following script and you will find the running logs in the `./LOG` folder!

```bash
cd NTUST-script
./00
```

### Rebuilding OAI L1, UE, or Re-executing
Sometimes you may only want to rebuild OAI L1 or UE, or simply re-execute the scripts. You can do this by running the following script, which comments out the build process for OSC DU.
```bash
./0
```