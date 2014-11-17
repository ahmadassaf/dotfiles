#!/usr/bin/env bash

# Pulling recent updates from the upstream and check for changes
git pull upstream master;

# Find the location of the script, this brings out the location of the current directory
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

function linkDotFiles() {
	# Link the files from source to the target with a dot appended to the front.
	find $SOURCE_LOCATION -mindepth 1 -maxdepth 1 -name '.*'| while read file; do
		if [ $(basename $file) != ".git" && $(basename $file) != ".gitignore" ]; then
  		if [[ -d ${HOME}/$(basename $file) ]]; then
  			echo "$(basename $file) is a driectory, removing a directory now .."
  			rm -r "${HOME}/$(basename $file)"
  		else
  			echo  "$(basename $file) is found, deleting and overwriting now!"
  			rm "${HOME}/$(basename $file)"
			fi
		  echo "Linking $file to $TARGET_LOCATION/$(basename $file)"
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

# Push changes that we got from the upstream to my forket github repo
git push github master;

