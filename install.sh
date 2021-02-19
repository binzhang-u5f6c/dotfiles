#!/usr/bin/bash

[ -d ~/.config ] || mkdir ~/.config
[ -d ~/.config/nvim ] || mkdir ~/.config/nvim

ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.xprofile ~/.xprofile

ln -sf ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/
ln -sf ~/.dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/
