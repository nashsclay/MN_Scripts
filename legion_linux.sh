#1/bin/bash
sudo apt-get update
sudo apt update
sudo apt-get -y upgrade
sudo apt -y upgrade
sudo apt-get -y install build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev 
git clone https://github.com/Legioncrypto/Legion.git
cd Legion-Source/src
mkdir -p obj/zerocoin
chmod +x leveldb/build_detect_platform
cd leveldb && make libleveldb.a libmemenv.a
cd ..
#change j2 to how many cores you want to use, if 4, then do j4
sudo make -j2 -f makefile.unix
echo
echo "File givesd is located in the src folder, current folder."
echo "To run type: ./givesd"
echo "and press enter. Press enter again after it says server starting to return to cli."
echo "Other commands that also work, ./givesd getinfo, ./givesd masternode status"
echo
