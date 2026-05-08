#!/bin/bash

INSTALLER_PATH="/tmp/vschaos2/Miniconda3-latest-Linux-x86_64.sh"
INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
INSTALL_DIR=${1:-"$HOME/miniconda3"}

# Check install dir
if [ -d "$INSTALL_DIR" ]; then
    echo "Miniconda already installed at $INSTALL_DIR, skipping."
fi

# Create download dir if needed
mkdir -p /tmp/vschaos2

# Download installer if needed
if [ -f "$INSTALLER_PATH" ]; then
    echo "Installer already exists at $INSTALLER_PATH, skipping download."
else
    echo "Downloading Miniconda installer..."
    curl -L "$INSTALLER_URL" -o "$INSTALLER_PATH"
    chmod +x "$INSTALLER_PATH"
fi

# Install
echo "Installing Miniconda at $INSTALL_DIR..."
bash "$INSTALLER_PATH" -b -p "$INSTALL_DIR"

source $INSTALL_DIR/bin/activate

echo "Installing environment..."
conda create -n vschaos python=3.11 -y
conda activate vschaos
pip install -r requirements.txt
