#!/usr/bin/bash

echo "Finding Prefix Path & Game Directory Path, this may take a moment..."

PREFIX_PATH=$(find / -type d -path "*/compatdata/9480/pfx" -print -quit 2> /dev/null)
GAME_DIRECTORY_PATH=$(find / -type d -path "*/steamapps/common/Saints Row 2" -print -quit 2> /dev/null)

# Directory Checks

if [[ $(ls "$GAME_DIRECTORY_PATH" -1 | grep saintsrow2) ]]; then
	echo "You seem to be using the native Linux version, this script will not work."
	echo "Please force the game to use Proton, to install the Windows version!"
	exit 1
fi

if ! [[ $(ls "$GAME_DIRECTORY_PATH" -1 | grep SR2_pc.exe) ]]; then
	echo "Cannot find 'SR2_pc.exe' in \"$2\""
	echo "Are you sure this is your Saints Row 2 game directory?"
	exit 1
fi

# Download Vulkan
echo "Downloading DXVK 1.10.3"
mkdir $(pwd)/Downloads/
cd $(pwd)/Downloads/
wget https://github.com/doitsujin/dxvk/releases/download/v1.10.3/dxvk-1.10.3.tar.gz -O $(pwd)/dxvk-1.10.3.tar.gz
tar -xvzf dxvk-1.10.3.tar.gz
rm "dxvk-1.10.3.tar.gz"

# Install Vulkan
cd dxvk-1.10.3
echo "Running DXVK Vulkan Install Script..."
WINEPREFIX="$PREFIX_PATH" ./setup_dxvk.sh install
cd $(pwd)/x32/
mv --force d3d9.dll dxgi.dll "$GAME_DIRECTORY_PATH"
echo "moving d3d9 and dxgi to \"$GAME_DIRECTORY_PATH\""

# Create dxvk.conf
cd "$GAME_DIRECTORY_PATH"
touch "dxvk.conf"
echo -en "dxgi.maxFrameLatency = 1\nd3d9.maxFrameLatency = 1\n\n#Caps game at 60FPS, rasing the limit above 60 can cause issues\ndxgi.maxFrameRate = 60\nd3d9.maxFrameRate = 60" >> dxvk.conf


echo -e "\n\nScript is complete, please open up the game with Steam and test it."
echo "If you face an issue, and it is not in the 'help.txt', please let me know here: https://github.com/dontna"
echo ""
echo -e "\033[21;1;4mIMPORTANT NOTE: Once you're in game, please go into the game settings > display and set "Dynamic Lighting" to "Simple" or "Off". This will improve performace drastically.\033[0m"
