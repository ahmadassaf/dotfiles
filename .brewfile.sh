# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  echo "Installing Homebrew"
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew"
brew doctor
brew update

# Install Homebrew recipes.
function brew_install_recipes() {
  recipes=($(setdiff "${recipes[*]}" "$(brew list)"))
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

# Given strings containing space-delimited words A and B, "setdiff A B" will
# return all words in A that do not exist in B. Arrays in bash are insane
# (and not in a good way).
# From http://stackoverflow.com/a/1617303/142339
function setdiff() {
  local debug skip a b
  if [[ "$1" == 1 ]]; then debug=1; shift; fi
  if [[ "$1" ]]; then
    local setdiffA setdiffB setdiffC
    setdiffA=($1); setdiffB=($2)
  fi
  setdiffC=()
  for a in "${setdiffA[@]}"; do
    skip=
    for b in "${setdiffB[@]}"; do
      [[ "$a" == "$b" ]] && skip=1 && break
    done
    [[ "$skip" ]] || setdiffC=("${setdiffC[@]}" "$a")
  done
  [[ "$debug" ]] && for a in setdiffA setdiffB setdiffC; do
    echo "$a ($(eval echo "\${#$a[*]}")) $(eval echo "\${$a[*]}")" 1>&2
  done
  [[ "$1" ]] && echo "${setdiffC[@]}"
}