#!/bin/bash

set -e

date
ps axjf

#################################################################
# Update Ubuntu and install prerequisites for running TWIST   #
#################################################################
sudo apt-get update
#################################################################
# Build TWIST from source                                     #
#################################################################
NPROC=$(nproc)
echo "nproc: $NPROC"
#################################################################
# Install all necessary packages for building TWIST           #
#################################################################
sudo apt-get install -y qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev libqrencode-dev libboost-all-dev build-essential libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libssl-dev libdb++-dev libssl-dev ufw git
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

cd /usr/local
file=/usr/local/twistX
if [ ! -e "$file" ]
then
        sudo git clone https://github.com/TWISTproject/core.git
fi

cd /usr/local/twistX/src
file=/usr/local/twistX/src/twistd
if [ ! -e "$file" ]
then
        sudo make -j$NPROC -f makefile.unix
fi

sudo cp /usr/local/core/src/twistd /usr/bin/twistd

################################################################
# Configure to auto start at boot                                      #
################################################################
file=$HOME/.twist
if [ ! -e "$file" ]
then
        sudo mkdir $HOME/.twist
fi
printf '%s\n%s\n%s\n%s\n' 'daemon=1' 'server=1' 'rpcuser=u' 'rpcpassword=p' | sudo tee $HOME/.twist/twist.conf
file=/etc/init.d/twist
if [ ! -e "$file" ]
then
        printf '%s\n%s\n' '#!/bin/sh' 'sudo twistd' | sudo tee /etc/init.d/twist
        sudo chmod +x /etc/init.d/twist
        sudo update-rc.d twist defaults
fi

/usr/bin/twistd
echo "TWIST has been setup successfully and is running..."
exit 0

