# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  echo "Installing Homebrew"
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew"
# brew doctor
# brew update

# Install Homebrew recipes.
function brew_install_recipes() {
  recipes=(setdiff "${recipes[*]}" "$(brew list)"))
  if (( ${#recipes[@]} > 0 )); then
    echo "Installing Homebrew recipes: ${recipes[*]}"
    for recipe in "${recipes[@]}"; do
      brew install $recipe
    done
  fi
}

# Homebrew recipes
recipes=(
	coreutils
	moreutils
	findutils
	gnu-sed --default-names
  bash
  bash-completion
  cowsay
  git
  git-extras
  htop-osx
  hub
  id3tool
  lesspipe
  man2html
  mercurial
  sl
  ssh-copy-id
  the_silver_searcher
  tree
  wget --enable-iri
  ringojs
	narwhal
	vim --override-system-vi
	homebrew/dupes/grep
	homebrew/dupes/screen
	bfg
	binutils
	binwalk
	cifer
	dex2jar
	dns2tcp
	fcrackzip
	foremost
	hashpump
	hydra
	john
	knock
	pngcheck
	sqlmap
	xz
	ack
	lynx
	node
	p7zip
	pigz
	pv
	rename
	rhino
	webkit2png
	zopfli
	heroku
)

# Start the actual installation of the recipes
brew_install_recipes
# Remove outdated versions from the cellar
brew cleanup