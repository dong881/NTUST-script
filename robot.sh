Target_PATH="."
LOG_PATH="$Target_PATH/LOG"
CONTROL_FILE="$Target_PATH/CONTROL"

# Create CONTROL file if it doesn't exist
if [ ! -e "$CONTROL_FILE" ]; then
    touch $CONTROL_FILE
    echo -n "1" > $CONTROL_FILE
fi

# LOG File name
OAI_CU_LOG_FILE="$LOG_PATH/1-OAI_CU.log"
RIC_LOG_FILE="$LOG_PATH/2-RIC_STUB.log"
ODU_LOG_FILE="$LOG_PATH/3-OSC_DU.log"
PNF_LOG_FILE="$LOG_PATH/PNF-nfapi-fixes.log"
UE_LOG_FILE="$LOG_PATH/5-OAI_UEsim.log"

SEARCH_STRING="pack_nr_rach_indication_body"
ERROR_STRING="ERROR"

check_logs_for_string() {
    for LOG_FILE in "$PNF_LOG_FILE"; do
        if grep -q "$SEARCH_STRING" "$LOG_FILE"; then
            return 1
        fi
        # if grep -q "$ERROR_STRING" "$LOG_FILE"; then
        #     return 2
        # fi
    done
    return 0
}

should_continue() {
    if [ -e "$CONTROL_FILE" ] && [ -f "$CONTROL_FILE" ]; then
        CONTROL_VALUE=$(cat "$CONTROL_FILE")
        if [ "$CONTROL_VALUE" -eq 1 ]; then
            return 0  # Continue
        fi
    fi
    return 1  # Stop
}

while true; do
    check_logs_for_string
    case $? in
        1)
            echo "Search string found in logs. Stopping script."
            # 刪除control檔案
            if [ -e "$CONTROL_FILE" ]; then
                rm "$CONTROL_FILE"
            fi
            exit 0
            ;;
        2)
            echo "Error detected in logs. Restarting..."
            bash "$Target_PATH/exit"
            bash "$Target_PATH/q"
            continue
            ;;
    esac
    should_continue
    if [ $? -eq 1 ]; then
        echo "Control file indicates to stop the script."
        bash "$Target_PATH/exit"
        bash "$Target_PATH/q"
        # 刪除control檔案
        if [ -e "$CONTROL_FILE" ]; then
            rm "$CONTROL_FILE"
        fi
        exit 0
    fi
    bash "$Target_PATH/0"
    sleep 1
done
