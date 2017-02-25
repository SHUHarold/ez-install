#!/bin/bash
# install common deps
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake make
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install libatlas-base-dev
sudo apt-get install python-dev
# install OpenCV
if [[ "$(which opencv_version)" == '' ]]; then
    echo "Installing OpenCV ..."
    sudo bash install-opencv.sh
fi
# install python deps
if [[ "$(which pip)" == '' ]]; then
    curl https://bootstrap.pypa.io/get-pip.py | sudo -H python
else
    sudo -H pip install --upgrade pip
fi
sudo -H pip install numpy scipy Cython
if [ ! -d /usr/lib/python2.7/dist-packages/numpy ]; then
    sudo ln -s /usr/local/lib/python2.7/dist-packages/numpy /usr/lib/python2.7/dist-packages/numpy
fi
echo '#numpy include path' >> ~/.bashrc
echo 'export CPATH=/usr/local/lib/python2.7/dist-packages/numpy/core/include:$CPP_INCLUDE_PATH' >> ~/.bashrc
echo 'export CPATH=/usr/local/lib/python2.7/dist-packages/numpy/core/include:$C_INCLUDE_PATH' >> ~/.bashrc
. ~/.bashrc
sudo apt-get install python-tk  # tkinter cannot install with pip
sudo -H pip install scikit-image scikit-learn
sudo -H pip install matplotlib
sudo -H pip install ipython jupyter
sudo -H pip install protobuf
sudo -H pip install h5py leveldb lmdb
sudo -H pip install networkx nose
sudo -H pip install pandas
sudo -H pip install python-dateutil
sudo -H pip install python-gflags pyyaml Pillow six pyzmq singledispatch
sudo -H pip install backports_abc certifi jsonschema graphviz  qtawesome pydot
# clone caffe source code
cd ~/ && git clone https://github.com/BVLC/caffe && cd caffe
mkdir build && cd build
cmake -DCPU_ONLY=ON .. && make -j$(nproc)
echo "Done!"

# try caffe MNIST example:
# cd ~/caffe
# bash data/mnist/get_mnist.sh
# bash examples/mnist/create_mnist.sh
# bash examples/mnist/train_lenet.sh
