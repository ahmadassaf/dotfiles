#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

<<<<<<< HEAD
git pull upstream master;
=======
git pull origin master;
>>>>>>> 6d4f94df9072221e7d3091d65a140ac2597975c6

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
<<<<<<< HEAD

git push github master;
=======
>>>>>>> 6d4f94df9072221e7d3091d65a140ac2597975c6
