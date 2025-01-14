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

# Remove versions for specific packages
sed -i '/torch/d' requirements.in
sed -i '/torchaudio/d' requirements.in
sed -i '/torchvision/d' requirements.in

# Add torch, torchaudio, and torchvision without version constraints
echo -e "torch\ntorchaudio\ntorchvision" >> requirements.in

# Compile and sync dependencies
pip-compile requirements.in
pip-sync requirements.txt
