#!/bin/bash

PREFIX=/home/mxana/anaconda3

sha256sum Anaconda3-2020.11-Linux-x86_64.sh
bash Anaconda3-2020.11-Linux-x86_64.sh
source /home/mxana/anaconda3/bin/activate
conda init
source ~/.bashrc
conda config --set auto_activate_base False or True
conda list
#anaconda-navigator
conda install -c conda-forge notebook