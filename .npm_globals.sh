# Install NPM globals
function npm_install_globals() {
  for global in "${globals[@]}"; do
    sudo npm install -g $global
  done
}

globals=(
  amok
  bosco
  bower
  caniuse
  caniuse-cmd
  cli
  eslint
  grunt-cli
  imageoptim
  imageoptim-cli
  jscs
  jshint
  marked
  mocha
  node-inspector
  nodemon
  notes
  prettyjson
  psi
  slap
  sparkly
  tmi
  vtop
  speed-test
  pm2
)

# Start the actual installation of the recipes
npm_install_globals