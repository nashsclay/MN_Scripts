#!/bin/bash
echo -e "Server is running with less than 2G of RAM without SWAP, creating swap."
SWAPFILE=$(mktemp)
dd if=/dev/zero of=$SWAPFILE bs=1024 count=2M
chmod 600 $SWAPFILE
mkswap $SWAPFILE
swapon -a $SWAPFILE
