#!/bin/bash

LOG_PATH="/home/yen0224/NTUST/LOG"
PID_FILE="$LOG_PATH/PID_FILE_NAME"

sudo kill -9 `cat $PID_FILE`