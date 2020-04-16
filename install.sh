#!/usr/bin/bash

[ -d ~/.config ] || mkdir ~/.config
[ -d ~/.config/nvim ] || mkdir ~/.config/nvim
[ -d ~/.ssh ] || mkdir ~/.ssh
[ -d ~/.v2ray ] || mkdir ~/.v2ray

ln -sf ~/Studio/00.Dotfiles/.config/gtk-3.0 ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/i3 ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/rofi ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/picom ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/dunst ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/kitty ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/v2ray ~/.config/
ln -sf ~/Studio/00.Dotfiles/.config/nvim/init.vim ~/.config/nvim/
ln -sf ~/Studio/00.Dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/

ln -sf ~/Studio/00.Dotfiles/.bashrc ~/.bashrc
ln -sf ~/Studio/00.Dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Studio/00.Dotfiles/.pam_environment ~/.pam_environment
ln -sf ~/Studio/00.Dotfiles/.ssh/config ~/.ssh/config
