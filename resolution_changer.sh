#!/usr/bin/bash

# Argument Checks
if [[ $1 == "--help" || $1 == "-h" ]]; then
	echo "Script usage: $0 [RESOLUTION_WIDTH] [RESOLUTION_HEIGHT] [PATH_TO_PREFIX]"
	echo ""
	echo "Realistic Usage"
	echo "$0 3440 1440 /home/dontna/.steam/steam/steamapps/compatdata/9480/pfx/"
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

if ! [[ $(ls "$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/" | grep settings.dat) || $(ls "$3/drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/" | grep settings.dat) ]]; then
	echo "Cannot find 'settings.dat' in \"$3/drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/\""
	echo "Are you sure this is your Saints Row 2 prefix?"
	exit 1
fi

### START OF THE ACTUAL SCRIPT ###
SCREEN_W=$1
SCREEN_H=$2

SCREEN_W_HEX=0"$(printf "%x" $SCREEN_W)"
SCREEN_H_HEX=0"$(printf "%x" $SCREEN_H)"

PATH_TO_PREFIX=$3

if ! [[ $(cd "$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/") ]]; then
	cd "$3/drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/"
else
	cd "$3drive_c/users/steamuser/AppData/Local/THQ/Saints Row 2/"
fi

function little_endian_converter() {
	## Yes this section contains 2 while loops that do basically the same thing. I know its poor code, but I just couldn't find another way to make it work. ##
	## Honestly, if you have an idea; PLEASE HELP... OH GOD HELP... THIS TOOK ME 5 HOURS and in that time I drank more Tea than any 1 human should ##
	## If any future employers are reading this... pretend you didn't see that? Thank you. I do very well under stressful situations, promise. ##

	CHAR_LENGTH=${#1}
	CHAR_LENGTH2=${#2}

	FIRST_SECTION=""
	SECOND_SECTION=""

	SECOND_LOOP=0

	# Little-Endian W
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
	
	echo -en "\x$FIRST_SECTION\x$SECOND_SECTION\\" | dd of=settings.dat bs=1 seek=60 count=2 conv=notrunc status=none

	# Little-Endian H
	while [ $CHAR_LENGTH2 -gt 0 ]; do
		CHAR_LENGTH2=$[$CHAR_LENGTH2-2]

		if ! [[ $SECOND_LOOP == 1 ]]; then
			FIRST_SECTION="$(echo -n ${2:$CHAR_LENGTH2:2})"
			SECOND_LOOP=1
		else
			SECOND_SECTION="$(echo -n ${2:$CHAR_LENGTH2:2})"
			SECOND_LOOP=0
		fi

	done

	echo -en "\x$FIRST_SECTION\x$SECOND_SECTION\\" | dd of=settings.dat bs=1 seek=64 count=2 conv=notrunc status=none

}	

little_endian_converter $SCREEN_W_HEX $SCREEN_H_HEX
echo "Script has sucessfully set your resolution to '$SCREEN_W x $SCREEN_H'"
