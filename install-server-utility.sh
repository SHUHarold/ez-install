#!/bin/bash
for name in openssh-server git 
do 
  sudo apt-get install ${name}
done