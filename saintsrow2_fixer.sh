#!/usr/bin/bash

# Argument Checks
if [[ $1 == "--help" || $1 == "-h" ]]; then
	echo "Script usage: $0 \"[PATH_TO_PREFIX]\" \"[PATH_TO_GAME_DIRECTORY]\""
	echo "Please refer to the 'help.txt' document, if you need more information."
	exit 0
fi

if [[ -z "$1" || -z "$2" ]]; then
	echo "Not enough aguments passed"
	exit 1
fi

# Directory Checks

if ! [[ $(ls "$2" -1 | grep SR2_pc.exe) ]]; then
	echo "Cannot find 'SR2_pc.exe' in \"$2\""
	echo "Are you sure this is your Saints Row 2 game directory?"
	exit 1
fi

PREFIX_PATH=$1
GAME_DIRECTORY_PATH=$2

# Download Vulkan
mkdir $(pwd)/Downloads/
cd Downloads/
wget https://github.com/doitsujin/dxvk/releases/download/v1.10.3/dxvk-1.10.3.tar.gz -O $(pwd)/dxvk-1.10.3.tar.gz
tar -xvzf dxvk-1.10.3.tar.gz
rm "dxvk-1.10.3.tar.gz"

# Install Vulkan
cd ../dxvk-1.10.3/
echo "Running DXVK Vulkan Install Script..."
WINEPREFIX="$PREFIX_PATH" ./setup_dxvk.sh install
mv --force d3d9.dll dxgi.dll "$GAME_DIRECTORY_PATH"

# Create dxvk.conf
cd "$GAME_DIRECTORY_PATH"
touch "dxvk.conf"
echo -en "dxgi.maxFrameLatency = 1\nd3d9.maxFrameLatency = 1\n\n#Caps game at 60FPS, rasing the limit above 60 can cause issues\ndxgi.maxFrameRate = 60\nd3d9.maxFrameRate = 60\n\nd3d9.textureMemory = 0" >> dxvk.conf

clear
echo "Script is complete, please open up the game with Steam and test it."
echo "If you face an issue, and it is not in the 'help.txt', please let me know here: https://github.com/dontna"
echo ""
echo -e "\033[21;1;4mIMPORTANT NOTE: Once you're in game, please go into the game settings > display and set "Dynamic Lighting" to "Simple" or "Off". This will improve performace drastically.\033[0m"
