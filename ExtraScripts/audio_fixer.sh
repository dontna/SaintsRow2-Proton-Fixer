#!/usr/bin/bash

if [[ $1 == "--help" || $1 == "-h" ]]; then
	echo "Script usage: $0 \"[PATH_TO_PREFIX]\""
	echo "Please refer to the 'help.txt' document, if you need more information or a pracitcal example."
	exit 0
fi

# Argument Checks

if [[ -z "$1" ]]; then
	echo "Not enough arguments passed."
	echo "Use '-h' for help"
	exit 0
fi

if ! [[ $(ls "$1" -1 | grep drive_c) ]]; then
	echo "Cannot find \"drive_c\" in \"$1\""
	echo "Are you sure this is your prefix?"
	exit 0
fi

PREFIX_PATH=$1

WINEPREFIX="$PREFIX_PATH" winetricks --force xact

clear
echo -e "Audio should now work correctly.\nSee the 'NEED HELP / REPORTING BUGS' section of the 'help.txt' file to find out how to report this fix as not working."
