#!/bin/bash
if [ ! -d /pkg/ ]; then
    sudo mkdir /pkg/ && sudo chmod 777 /pkg/
fi
cd /pkg && git clone https://github.com/NVIDIA/nccl
cd nccl
make CUDA_HOME=/usr/local/cuda test -j$(nproc)
make PREFIX=/pkg/nccl install -j$(nproc)
echo '--------------compile done !'
echo 'extra step1:'
echo 'add "export LD_LIBRARY_PATH=/pkg/nccl/lib:$LD_LIBRARY_PATH" to  "/etc/bash.bashrc"'
echo 'extra ste2:'
echo 'add "export CPATH=/pkg/nccl/include:$CPATH" to  "/etc/bash.bashrc"'
echo 'extra step3:'
echo 'run "source /etc/bash.bashrc"'
if [ $? == 0 ]; then
    echo "ALL Done!"
fi

