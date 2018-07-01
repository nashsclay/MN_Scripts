#!/bin/bash
#THIS SCRIPT MUST BE RAN AS ROOT
#Variables
declare -i nodes=0        #The number of nodes currently installed
declare -i addnodes=0     #The number of nodes to add
declare -i nodesadded=0   #The number of nodes added
declare -a mnkeys=()      #The array to store the masternode private keys
declare -i rpcport=15825  #Default rpc port
declare -i port=15800     #Default port
#The array that holds names of all required packages
declare -a packages=("git" "libgmp3-dev" "automake" "build-essential" "libtool" "autotools-dev" "autoconf" "pkg-config" "libssl-dev" "libboost-all-dev" "libevent-dev" "nano" "software-properties-common")
declare -a packages2=("libdb4.8-dev" "libdb4.8++-dev" "libminiupnpc-dev")

#This function checks how many nodes are installed and will install wallet if needed
check_nodes()  {
  echo "****************************************************************************"
  echo "*    Ubuntu 14.04 is the recommended opearting system for this install.    *"
  echo "*                                                                          *"
  echo "*     This script will install and configure your TurboGold masternodes.      *"
  echo "****************************************************************************"
  echo "Welcome to the TurboGold masternode setup script"
  sleep 2
  nodes+=$( find /root/ -type d -name '.Turbogold*[0-9]' | wc -l ) >/dev/null 2>&1
}

#This function takes in user information for setup
config()  {
  echo "You currently have $(tput setaf 2)$nodes$(tput sgr0) nodes installed on this device"
  sleep 2
  echo "How many nodes do you want to add to this system?"
  read addnodes
  declare -i current=0
  while [[ $current -lt $addnodes ]]
  do
    echo "Please enter node $((current+1)) masternode genkey."
    echo "$(tput setaf 1)MAKE SURE THAT YOU ENTERED THE MASTERNODE GENKEY EXACTLY BEFORE YOU HIT [ENTER]$(tput sgr0)"
    read mnkeys[$current]
    echo "You entered $(tput setaf 2)${mnkeys[$current]}$(tput sgr0) as your first masternode genkey"
    current+=1
    sleep 2
  done
  echo "This is the end of the required user input. You may leave this running to complete on its own"
}

#This function will install the TurboGold wallet
install_wallet()  {
  if [ -d "/root/turbogold" ]; then
    return 0
  fi
  echo "You do not have the TurboGold wallet installed on this device"
  sleep 2
  echo "ADDING 2GB SWAP FILE"
  sleep 2
  dd if=/dev/zero of=/mnt/turbogoldswap.swap bs=2M count=1000 >/dev/null 2>&1
  mkswap /mnt/turbogoldswap.swap >/dev/null 2>&1
  swapon /mnt/turbogoldswap.swap >/dev/null 2>&1
  echo "RUNNING UPDATES AND INSTALLING ALL REQUIRED PACKAGES"
  sudo apt-get update -y >/dev/null 2>&1
 sudo apt-get upgrade -y >/dev/null 2>&1
  declare -i current=0
  for i in "${packages[@]}"; do
    if ! { sudo apt-get install "${packages[current]}" -y >/dev/null 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
      echo "$(tput setaf 2)${packages[current]}$(tput sgr0) successfully installed or updated"
    else
      echo "$(tput setaf 1)${packages[current]}$(tput sgr0) failed to install"
      exit 1
    fi
    current+=1
  done
  sudo add-apt-repository ppa:bitcoin/bitcoin -y >/dev/null 2>&1
  sudo apt-get update -y >/dev/null 2>&1
  declare -i current2=0
  for i in "${packages2[@]}"; do
    if ! { sudo apt-get install "${packages2[current2]}" -y >/dev/null 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
      echo "$(tput setaf 2)${packages2[current2]}$(tput sgr0) successfully installed or updated"
    else
      echo "$(tput setaf 1)${packages2[current2]}$(tput sgr0) failed to install"
      exit 1
    fi
    current2+=1
  done
  echo "DOWNLOADING TURBOGOLD WALLET"
  git clone https://github.com/zero24x/turbogold >/dev/null 2>&1
  echo "INSTALLING TURBOGOLD WALLET"
  sleep 2
  echo "THIS PROCESS WILL TAKE A LONG TIME WITHOUT ANY OUTPUT ON THE SCREEN"
  cd turbogold/src && make -f makefile.unix >/dev/null 2>&1
}

#This function will add additional nodes
add_nodes() {
  declare -i current=$((nodes+1))
  declare -i total=$((nodes+addnodes))
  while [[ $current -lt $total ]] || [[ $current -eq $total ]]
  do
    echo "Configuring TurboGold node $current"
    mkdir /root/.Turbogold$current
    touch /root/.Turbogold$current/Turbogold.conf
    usrnam=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
    usrpas=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
    vpsip=$(curl -s4 icanhazip.com)
    echo -e "rpcuser=$usrnam \nrpcpassword=$usrpas \nrpcport=$((rpcport+current)) \nrpcallowip=127.0.0.1 \nlisten=1 \nserver=1 \ndaemon=1 \nmasternode=1 \nport=$((port+current))  \nmasternodeprivkey=${mnkeys[$nodesadded]} \nexternalip=$$
    /root/turbogold/src/Turbogoldd -datadir=/root/.Turbogold$current -config=/root/.Turbogold$current/Turbogold.conf -daemon >/dev/null 2>&1
    echo "alias Turbogoldd$current='/root/turbogold/src/Turbogoldd -datadir=/root/.Turbogold$current -config=/root/.Turbogold$current/Turbogold.conf'" >> /root/.bashrc
    nodesadded+=1
    current+=1
    sleep 2
  done
}

conclusion()  {
  echo 'Wait until the blockchain is synced to start each alias.'
  sleep 2
  echo 'Enjoy your Masternodes!'
  sleep 2
  echo "****************************************************************************"
  echo "*                         $(tput setaf 3)USEFUL TURBOGOLDD COMMANDS$(tput sgr0)                          *"
  echo "****************************************************************************"
  echo '*-daemon - This command is used to start the daemon                        *'
  echo '*stop - This command is used to stop the daemon                            *'
  echo '*getinfo - This command can be used to check block height                  *'
  echo '*masternode status - This command is used to view masternode status.       *'
  echo '*masternode debug - This command can be used if you do not get status 9    *'
  echo "****************************************************************************"
  echo "*          To use each command, it must be preceeded by Turbogoldd#           *"
  echo "****************************************************************************"
}

#main
clear
check_nodes
config
install_wallet
add_nodes
conclusion













