#!/bin/bash

LOG_PATH="/home/hpe/NTUST-script/LOG"
PID_FILE="$LOG_PATH/PID_FILE_NAME"
if [ -e $PID_FILE ]; then
    sudo kill -9 `cat $PID_FILE`
    rm $PID_FILE
fi