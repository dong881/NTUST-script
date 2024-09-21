ROOT_PATH=$(pwd | awk -F'/' '{print $3}')
HOME_DIR=$(eval echo ~$USER)
export PATH_TO_SCRIPT="$HOME_DIR/$ROOT_PATH/NTUST-script"
export PATH_TO_CU="$HOME_DIR/$ROOT_PATH/O-CU"
export PATH_TO_O_DU_L2="$HOME_DIR/$ROOT_PATH/O-DU/l2"
export PATH_TO_L1_UE="$HOME_DIR/$ROOT_PATH/OAI_L1_UE"
echo "ROOT_PATH: $ROOT_PATH"
echo "HOME_DIR: $HOME_DIR"
# export PATH_TO_CU="/home/$ROOT_PATH/bmwlab_tony_cu_du"
# export PATH_TO_O_DU_L2="/home/$ROOT_PATH/mwnl-odu-at-oai-based-on-scf/l2"
# export PATH_TO_L1_UE="/home/$ROOT_PATH/openairinterface5g"
