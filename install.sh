#!/usr/bin/env bash

# https://github.com/iagodahlem/dotfiles/blob/master/install-dotfiles.sh for ref
# IDEAS:
# make all npm, node packages in a list type thing 'npm install -g $(cat nmp/globals|grep -v "#")'
# wins64 fonts, code folder and s like that
# my main code folder, could start with subdirectories
#
################################################################################

INFOCOLOR='\033[0;32m'
NOCOLOR='\033[0m' #Nocolor
echo_alert () {
    echo "${INFOCOLOR}$1${NOCOLOR}"
}

readonly CONFIG="$HOME/.config"
cd ~
#######################################################################################################################
echo_alert "Starting the init of this system......."
sudo -v
apt update
apt upgrade
apt-get update
#######################################################################################################################
echo_alert "Installing everythig to do with package managers......."
apt install black python3-pip zsh git cargo ripgrep fd-find pass unzip openssh ii.
pip install flake8 pynvim
######################################################################################################################
echo_alert "Installing rust and cargo packages......."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install stylua

mkdir -p ~/.local/bin
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
#######################################################################################################################
echo_alert "Installing zshrc......."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#######################################################################################################################
echo_alert "Installing node and everythig using npm........"
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install node
npm install -g npm-check-updates @tailwindcss/language-server typescript-language-server typescript live-server create-react-app next react react-dom sass
#######################################################################################################################
echo_alert "Install:\nhttps://git-scm.com/download/win\n"
echo_alert "Installing neovim........"
add-apt-repository ppa:neovim-ppa/stable
apt-get install neovim
#######################################################################################################################
echo_alert "Setting up symlinks......."
rm -rf ~/.zshrc && ln -s ~/.config/zsh/.zshrc ~/.zshrc 
ln -s "$CONFIG/git/.gitconfig" ~/.gitconfig
ln -s "$CONFIG/git/.gitignore_global" ~/.gitignore_global
ln -s "$CONFIG/git/.gitmessage" ~/.gitmessage
#######################################################################################################################
EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
sudo unzip -q exa.zip bin/exa -d /usr/local
#######################################################################################################################

