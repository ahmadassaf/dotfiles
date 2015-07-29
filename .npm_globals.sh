# Install NPM globals
function npm_install_globals() {
  for global in "${globals[@]}"; do
    sudo npm install -g $global
  done
}

globals=(
  amok
  bower
  caniuse
  cli
  eslint
  grunt
  imageoptim
  jscs
  mocha
  nodemon
  prettyjson
  psi
  should
  slap
  sparkly
  tmi
  vtop
)

# Start the actual installation of the recipes
npm_install_globals