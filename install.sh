#!/usr/bin/bash

[ -d ~/.config ] || mkdir ~/.config
[ -d ~/.config/nvim ] || mkdir ~/.config/nvim
[ -d ~/.config/nvim/lua ] || mkdir ~/.config/nvim/lua
[ -d ~/.config/nvim/lua/config ] || mkdir ~/.config/nvim/lua/config
[ -d ~/.config/nvim/lua/plugins ] || mkdir ~/.config/nvim/lua/plugins

ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/xprofile ~/.xprofile

ln -sf ~/.dotfiles/nvim/init.lua ~/.config/nvim/
ln -sf ~/.dotfiles/nvim/lua/config/lazy.lua ~/.config/nvim/lua/config/
ln -sf ~/.dotfiles/nvim/lua/plugins/cmp.lua ~/.config/nvim/lua/plugins/
ln -sf ~/.dotfiles/nvim/lua/plugins/edit.lua ~/.config/nvim/lua/plugins/
ln -sf ~/.dotfiles/nvim/lua/plugins/lsp.lua ~/.config/nvim/lua/plugins/
ln -sf ~/.dotfiles/nvim/lua/plugins/ui.lua ~/.config/nvim/lua/plugins/
