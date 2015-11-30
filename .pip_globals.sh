# Install PIP globals
function pip_install_globals() {
  for global in "${globals[@]}"; do
    sudo pip install $global
  done
}

globals=(
  aws
  awscli
  choosealicense-cli
  harvey
  httpie
  saws
)

# Start the actual installation of the recipes
pip_install_globals