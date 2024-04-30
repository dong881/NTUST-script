#!/bin/bash

LOG_PATH="/home/hpe/NTUST-script/LOG"
PID_FILE="$LOG_PATH/PID_FILE_NAME"

sudo kill -9 `cat $PID_FILE`