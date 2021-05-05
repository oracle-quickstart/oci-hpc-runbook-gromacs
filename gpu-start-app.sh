#!/bin/bash -v

echo "gpu-start-app"
echo $*

# Stop the firewall to allow communication with the nodes
# TODO: find the exact ports to open
sudo systemctl stop firewalld


if [ "$3" != "" ]
then
    echo Installing Gromacs
    mkdir /mnt/block/gromacs
    chmod +x /mnt/block/gromacs
    cd /mnt/block/gromacs
    wget -O - $3 | tar xvz
    chmod +x /mnt/block/gromacs/*
    echo source /mnt/block/gromacs/binaries/bin/GMXRC | sudo tee -a ~/.bashrc
    echo export PATH=/mnt/block/gromacs/binaries/bin/:\$PATH | sudo tee -a ~/.bashrc
    source ~/.bashrc
fi

if [ "$2" != "" ]
then
    echo Downloading model
    mkdir /mnt/block/work
    chmod +x /mnt/block/work
    cd /mnt/block/work
    wget $2
    chmod +x /mnt/block/work/*
    echo export PATH=/mnt/block/work/:\$PATH | sudo tee -a ~/.bashrc
    source ~/.bashrc
fi