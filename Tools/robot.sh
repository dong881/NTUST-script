#!/bin/bash
source ../VARIABLE.sh

SEARCH_STRING="RA-Msg3 transmitted"
ERROR_STRING="asdfghjkl;"

################################################

Target_PATH="$PATH_TO_SCRIPT"
LOG_PATH="$Target_PATH/LOG"
CONTROL_FILE="$Target_PATH/CONTROL"

# LOG File name
OAI_CU_LOG_FILE="$LOG_PATH/1-OAI_CU.log"
RIC_LOG_FILE="$LOG_PATH/2-RIC_STUB.log"
ODU_LOG_FILE="$LOG_PATH/3-OSC_DU.log"
PNF_LOG_FILE="$LOG_PATH/4-OAI_PNF.log"
UE_LOG_FILE="$LOG_PATH/5-OAI_UE.log"
TCP_LOG_FILE="$LOG_PATH/TCPdump.pcap"

# Create CONTROL file if it doesn't exist
if [ ! -e "$CONTROL_FILE" ]; then
    touch $CONTROL_FILE
    echo -n "1" > $CONTROL_FILE
fi

check_logs_for_string() {
    for LOG_FILE in "$UE_LOG_FILE"; do
        if grep -q "$SEARCH_STRING" "$LOG_FILE"; then
            return 1
        fi
        if grep -q "$ERROR_STRING" "$LOG_FILE"; then
            return 2
        fi
    done
    return 0
}

should_continue() {
    if [ -e "$CONTROL_FILE" ] && [ -f "$CONTROL_FILE" ]; then
        CONTROL_VALUE=$(cat "$CONTROL_FILE")
        if [ -n "$CONTROL_VALUE" ] && [ "$CONTROL_VALUE" -eq 1 ]; then
            return 0  # Continue
        fi
    fi
    return 1  # Stop
}

check_logs_for_string
case $? in
    1)
        echo "Search string found in logs. Stopping script."
        if [ -e "$CONTROL_FILE" ]; then
            rm "$CONTROL_FILE"
        fi
        exit 0
        ;;
    2)
        echo "Error detected in logs. Restarting..."
        cd $Target_PATH
        bash "$Target_PATH/0"
        ;;
esac
should_continue
if [ $? -eq 1 ]; then
    echo "Control file indicates to stop the script."
    if [ -e "$CONTROL_FILE" ]; then
        rm "$CONTROL_FILE"
    fi
    exit 0
fi
cd $Target_PATH
bash "$Target_PATH/0"

