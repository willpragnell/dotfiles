#!/usr/bin/env bash

set -e -u -x

OS=$(uname)
if [[ $OS == 'Darwin' ]]; then
    # TODO check for brew and bail if needed
    brew bundle
elif [[ $OS == 'Linux' ]]; then
    sudo apt update
    sudo apt install -y git stow zsh fzf tmux vim python3-pip
else
    echo "Unknown OS: $OS!"
    exit 1
fi

if [[ ! -d ~/.config/base16-shell ]]; then
    git clone git@github.com:chriskempson/base16-shell ~/.config/base16-shell
fi

stow -t ~ zsh
chsh -s "$(command -v zsh)"

stow -t ~ git

stow -t ~ tmux

stow -t ~ vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugUpdate +PlugClean! +qall
pip3 install vim-vint
