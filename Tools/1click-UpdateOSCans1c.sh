#!/bin/bash
shopt -s extglob
if [ -z "$PATH_TO_O_DU_L2" ]; then
    read -p "Please enter the o-du-l2 path: " PATH_TO_O_DU_L2
    export PATH_TO_O_DU_L2
fi
BASE_DIR="$PATH_TO_O_DU_L2"
sudo rm -rf "$BASE_DIR/src/codec_utils/RRC/"* && \
sudo /opt/asn1c/bin/asn1c \
    -pdu=all \
    -fcompound-names \
    -gen-UPER \
    -no-gen-BER \
    -no-gen-JER \
    -no-gen-OER \
    -gen-APER \
    -no-gen-example \
    -findirect-choice \
    -D "$BASE_DIR/src/codec_utils/RRC" \
    ~/NTUST-script/ASN1_file/rrc_15_3.asn1 && \
~/NTUST-script/Tools/Pick-commonFiles.sh RRC && \

sudo rm -rf "$BASE_DIR/src/codec_utils/F1AP/"* && \
sudo /opt/asn1c/bin/asn1c \
    -pdu=all \
    -fcompound-names \
    -gen-APER \
    -no-gen-BER \
    -no-gen-JER \
    -no-gen-OER \
    -gen-UPER \
    -no-gen-example \
    -findirect-choice \
    -fno-include-deps \
    -D "$BASE_DIR/src/codec_utils/F1AP" \
    ~/NTUST-script/ASN1_file/F1.asn1 && \
~/NTUST-script/Tools/Pick-commonFiles.sh F1AP

sudo rm -rf "$BASE_DIR/src/codec_utils/E2AP/"* && \
sudo /opt/asn1c/bin/asn1c \
    -gen-APER \
    -no-gen-OER \
    -fcompound-names \
    -no-gen-example \
    -findirect-choice \
    -fno-include-deps \
    -D "$BASE_DIR/src/codec_utils/E2AP" \
    ~/NTUST-script/ASN1_file/E2APV0300.asn1 && \
~/NTUST-script/Tools/Pick-commonFiles.sh E2AP

sudo rm -rf "$BASE_DIR/src/codec_utils/E2SM_KPM/"* && \
sudo /opt/asn1c/bin/asn1c \
    -no-gen-BER \
    -gen-UPER \
    -no-gen-OER \
    -no-gen-JER \
    -fcompound-names \
    -no-gen-example \
    -findirect-choice \
    -fno-include-deps \
    -D "$BASE_DIR/src/codec_utils/E2SM_KPM" \
    ~/NTUST-script/ASN1_file/ASN.1_KPM_v2.03.asn \
    ~/NTUST-script/ASN1_file/ASN.1_SM_v2.01.asn && \
~/NTUST-script/Tools/Pick-commonFiles.sh E2SM_KPM

# sudo rm -f "$BASE_DIR/src/codec_utils/common"/{ber_,oer_,jer_}* "$BASE_DIR/src/codec_utils/common"/*_{jer,ber,oer}.*(N)

# Record original path and switch to the common directory
original_dir=$(pwd)

cd "$BASE_DIR"
sudo git apply --reject --whitespace=fix ~/NTUST-script/patch/Cleanup-unnecessary-encoding-files.patch
sudo git apply --reject --whitespace=fix ~/NTUST-script/patch/Ming-Fixed-all-compilerERROR.patch

cd "$BASE_DIR/src/codec_utils/common"

# sudo rm -f {oer,jer,der}_* *_{oer,jer,der}.* 2>/dev/null || true
sudo find . -type f \( -name "[ojd]er_*" -o -name "*_[ojd]er.*" \) -delete
sudo find . -type f \( -name "*_ber.*" \) -delete
sudo rm ber_decoder.c ber_decoder.h

# Return to the original directory
cd "$original_dir"