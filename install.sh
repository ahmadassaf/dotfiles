#!/usr/bin/env bash

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

function linkDotFiles() {

    echo "Linking required dotfiles ...";

	# Link the files from source to the target with a dot appended to the front.
	find $SOURCE_LOCATION/dotfiles -mindepth 1 -maxdepth 1 -name '.*'| while read file; do
		if [[ $(basename $file) != ".git" && $(basename $file) != ".gitignore" ]]; then
      		if [[ -d ${HOME}/$(basename $file) ]]; then
      			echo "${NC}$(basename $file)${NC} is a driectory, ${red}removing a directory now ..${NC}"
      			rm -r "${HOME}/$(basename $file)"
      		elif [[ -f ${HOME}/$(basename $file) ]]; then
      			echo "${magenta}$(basename $file)${NC} is found, ${red}deleting and overwriting now!${NC}"
      			rm "${HOME}/$(basename $file)"
    		fi
		    echo "Linking ${magenta}$file${NC} to ${magenta}$TARGET_LOCATION/$(basename $file)${NC}"
	        ln -s "$file" "${HOME}/$(basename $file)"
        fi
	done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	linkDotFiles;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? [Y/N] " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		linkDotFiles;
	fi;
fi;
unset linkDotFiles;

if [[ ! -e ${HOME}/.dircolors ]]; then
	# Prompt the user if he wishes to have dircolors enabled
	printf "${magenta}\nDircolors${NC} helps applying different colors for file groups when executing ${red}ls${NC}\n"
	read -p "This will enable dircolors. Are you sure? [Y/N]" -n 1;
	printf "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		ln -s "$SOURCE_LOCATION/dotfiles/dircolors/LS_COLORS" "${HOME}/.dircolors"
	fi;
fi
