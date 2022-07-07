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
apt install nodejs npm black python3-pip zsh git cargo ripgrep fd-find pass
pip install flake8 pynvim
######################################################################################################################
echo_alert "Installing rust and cargo packages......."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install stylua
#######################################################################################################################
echo_alert "Installing zshrc......."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#######################################################################################################################
echo_alert "Installing node and everythig using npm........"
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install node
npm install -g @tailwindcss/language-server typescript-language-server typescript live-server create-react-app next react react-dom
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
echo_alert "Install:\nhttps://git-scm.com/download/win\n"
