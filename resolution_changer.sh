#!/usr/bin/bash

# Argument Checks
if [[ $1 == "--help" || $1 == "-h" ]]; then
	echo "Script usage: $0 [RESOLUTION_WIDTH] [RESOLUTION_HEIGHT] [PATH_TO_PREFIX]"
	echo ""
	echo "Realistic Usage"
	echo "$0 3440 1440 home/dontna/.local/share/Steam/steamapps/compatdata/9480/pfx/"
	exit 0
fi


if [[ -z "$1" || -z "$2" || -z $3 ]]; then
	echo "Not enough aguments passed"
	exit 1
fi

if [[ ${#1} -gt 4 || ${#2} -gt 4 ]]; then
	echo "The resolution '$1x$2', doesn't seem right. Please fix errors and try again."
	exit 1
fi

### START OF THE ACTUAL SCRIPT ###
SCREEN_W=$1
SCREEN_H=$2

SCREEN_W_HEX=0"$(printf "%x" $SCREEN_W)"
SCREEN_H_HEX=0"$(printf "%x" $SCREEN_H)"

PATH_TO_PREFIX=$3

if ! [[ $(ls "$3drive_c/users/steamuser/") ]]; then
	PATH_TO_PREFIX="$3/"
fi

# Check to see if the settings folder is located in AppData or Local Settings.
if ! [[ $(ls "$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/") ]]; then
	PATH_TO_SETTINGS="$3drive_c/users/steamuser/Local Settings/Application Data/THQ/Saints Row 2/"
elif [[ $(ls "$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/") ]]; then
	PATH_TO_SETTINGS="$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/"
else
	echo "Cannot locate 'settings.dat', are you sure '$3' is your prefix path?"
	exit 1
fi

function little_endian_converter() {
	# Function that takes HEX input and converts it to little endian. It also overwrites the old bytes, in 'settings.dat', with the new little endian hex.
	CHAR_LENGTH=${#1}

	FIRST_SECTION=""
	SECOND_SECTION=""

	SECOND_LOOP=0

	while [ $CHAR_LENGTH -gt 0 ]; do
		CHAR_LENGTH=$[$CHAR_LENGTH-2]

		if ! [[ $SECOND_LOOP == 1 ]]; then
			FIRST_SECTION=$(echo -n ${1:$CHAR_LENGTH:2})
			SECOND_LOOP=1
		else
			SECOND_SECTION=$(echo -n ${1:$CHAR_LENGTH:2})
			SECOND_LOOP=0
		fi
	done
	
	echo -en "\x$FIRST_SECTION\x$SECOND_SECTION\\" | dd of=settings.dat bs=1 seek=$2 count=2 conv=notrunc status=none
}	

cd "$PATH_TO_SETTINGS"

little_endian_converter $SCREEN_W_HEX 60
little_endian_converter $SCREEN_H_HEX 64

clear
echo "Script has sucessfully set your resolution to '$SCREEN_W x $SCREEN_H'"
