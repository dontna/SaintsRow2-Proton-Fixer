#!/usr/bin/bash

PREFIX_PATH=$(find / type -d -path "*/compatdata/9480/pfx" -print -quit 2> /dev/null)

if ! [[ $(ls "$PREFIX_PATH" -1 | grep drive_c) ]]; then
	echo "Cannot find \"drive_c\" in \"$1\""
	echo "Are you sure this is your prefix?"
	exit 0
fi

export WINEPREFIX="$PREFIX_PATH" 

winetricks --force xact

echo -e "Audio should now work correctly.\nSee the 'NEED HELP / REPORTING BUGS' section of the 'help.txt' file to find out how to report this fix as not working."
