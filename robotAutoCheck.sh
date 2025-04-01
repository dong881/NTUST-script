#!/bin/bash
l="/home/hpe/NTUST-script/LOG/5-OAI_UE.log"
ec=("synch Failed" "RAR reception failed") # "Lost socket"
bash ./exit
while :; do
    bash ./all-in-one
    while :; do
        flag=0
        for e in "${ec[@]}"; do
            if grep -q "$e" "$l"; then
                echo -e "Error condition '$e' detected.\r"
                bash ./exit
                flag=1
                break
            fi
        done
        [ $flag -eq 1 ] && break
        grep -q "cumulated bad DCI" "$l" && { echo -e "cumulated bad DCI detected. Exiting loop.\r"; exit 0; }
        sleep 1
    done
done