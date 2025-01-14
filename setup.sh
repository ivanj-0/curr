#!/bin/bash

# Clone the repository
git clone https://github.com/OpenMOSS/AnyGPT.git
cd AnyGPT

# Create and activate Conda environment
conda create --name AnyGPT python=3.9 -y
conda init
source /root/.bashrc
conda activate AnyGPT

# Prepare for dependency management
mv requirements.txt requirements.in
pip install pip-tools

sed -i 's/torch[^ ]*/torch/' requirements.in
sed -i 's/torchaudio[^ ]*/torchaudio/' requirements.in
sed -i 's/torchvision[^ ]*/torchvision/' requirements.in
sed -i '/gradio==3.50.0/d' requirements.in


# Add torch, torchaudio, and torchvision without version constraints
echo -e "\ntorch\ntorchaudio\ntorchvision" >> requirements.in

# Compile and sync dependencies
pip-compile requirements.in

apt-get update -y
apt-get install -y build-essential
apt-get install -y python3-dev

pip-sync requirements.txt
