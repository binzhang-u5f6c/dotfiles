#!/usr/bin/bash

[ -d ~/.config ] || mkdir ~/.config
[ -d ~/.config/nvim ] || mkdir ~/.config/nvim
[ -d ~/.config/qtile ] || mkdir ~/.config/qtile
[ -d ~/.config/termite ] || mkdir ~/.config/termite

ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.xprofile ~/.xprofile

ln -sf ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/
ln -sf ~/.dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/
ln -sf ~/.dotfiles/.config/qtile/config.py ~/.config/qtile/
ln -sf ~/.dotfiles/.config/termite/config ~/.config/termite/
