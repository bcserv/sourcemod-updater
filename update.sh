#!/bin/bash

# Usage: ./update /path/cstrike/ <URL> --snapshot-dev --snapshot-stable --install --dontask --fixpermissions

# change to the script's directory
cd $(dirname "$(readlink -f "$0")")

# load all functions
for f in $(find functions/ -name '*.func'); do
	. "$f"
done

define_colors

echo -e "$header Bcserv Sourcemod updater $reset"
echo ""

# declare associative array for the options, as bash can't
# serialize this into the ENV, it is defined here.
declare -A options
# read the options in
read_options $*

# load settings
. "settings"

directory_game="$1"

if [[ $2 != "" && ${2:0:2} != "--" ]]; then
	url_sourcemod_package="$2"
fi

if [[ $directory_game == "" ]]; then
	echo -e "${red}Error: You have to specify a path to your srcds game directory (example: /path_to/css/cstrike)$reset"
	exit -1
fi

download

if [[ $? == 1 ]]; then

	if [[ ${options[dontask]} != "1" ]]; then
		echo -e "${cyan}I will do the update now, press any key to continue${reset}, $red'CTRL + C' to exit$reset"
		echo ""
		stty -echo
		read -n 1
		stty echo
	fi

	update

	if [[ $? == 0 ]]; then
		echo -e "${red}Error found, aborting."
	fi

	# Cleanup
	rm -R "$temp"
fi
