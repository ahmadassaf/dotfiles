#!/usr/bin/env bash

function linkDotFiles() {
	# Link the files from source to the target with a dot appended to the front.
	find $SOURCE_LOCATION/dotfiles -mindepth 1 -maxdepth 1 -name '.*'| while read file; do
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
	    ln -s "$file" "${HOME}/.sshrc.d/$(basename $file)"
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
	echo "${magenta}\nDircolors${NC} helps applying different colors for file groups when executing ${red}ls${NC}\n"
	read -p "This will enable dircolors. Are you sure? [Y/N]" -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		ln -s "$SOURCE_LOCATION/dotfiles/dircolors/LS_COLORS" "${HOME}/.dircolors"

		# Adding needed configurations to appearance.bash in bash-it
		echo "Applying needed patched to ${red}appearance.bash${NC}"
		echo "\n\n# Adding needed files for dircoloring
export PATH=\"/usr/local/opt/coreutils/libexec/gnubin:\$PATH\"
export MANPATH=\"/usr/local/opt/coreutils/libexec/gnuman:\$MANPATH\"
# Enabling dircolors coloring
eval \`gdircolors -b ~/.dircolors\`" >> "${HOME}/.bash_it/lib/appearance.bash"

		# Adding needed configurations to theme-and-appearance in oh-my-zsh
		echo "Applying needed patched to ${red}theme-and-appearance.zsh${NC}"
		echo "\n\n# Enabling dircolors coloring
eval \`gdircolors -b ~/.dircolors\`" >> "${HOME}/.oh-my-zsh/lib/theme-and-appearance.zsh"
	fi;
fi

	read -p "This will install [grc] coloring to the terminal. Are you sure? [Y/N] " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
				# Adding needed configurations to appearance.bash in bash-it
		echo "Applying needed patched to ${red}appearance.bash${NC}"
		echo "\n\n# If we have grc enabled this is used to add coloring to various commands
source "`brew --prefix grc`/etc/grc.bashrc""

		# Adding needed configurations to theme-and-appearance in oh-my-zsh
		echo "Applying needed patched to ${red}theme-and-appearance.zsh${NC}"
		echo "\n\n# If we have grc enabled this is used to add coloring to various commands
source "`brew --prefix grc`/etc/grc.bashrc""
	fi;

