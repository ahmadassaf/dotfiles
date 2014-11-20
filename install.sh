#!/usr/bin/env bash

function linkDotFiles() {
	# Link the files from source to the target with a dot appended to the front.
	find $SOURCE_LOCATION -mindepth 1 -maxdepth 1 -name '.*'| while read file; do
		if [[ $(basename $file) != ".git" && $(basename $file) != ".gitignore" ]]; then
  		if [[ -d ${HOME}/$(basename $file) ]]; then
  			echo "${NC}$(basename $file)${NC} is a driectory, ${red}removing a directory now ..${NC}"
  			rm -r "${HOME}/$(basename $file)"
  		else
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
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		linkDotFiles;
	fi;
fi;
unset linkDotFiles;

