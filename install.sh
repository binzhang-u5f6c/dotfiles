#!/usr/bin/bash

sudo cp 10_time_synchronization.sh /etc/NetworkManager/dispatcher.d/10_time_synchronization.sh
sudo chown root:root /etc/NetworkManager/dispatcher.d/10_time_synchronization.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/10_time_synchronization.sh

sudo cp lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
sudo chown root:root /etc/lightdm/lightdm-gtk-greeter.conf
sudo chmod 644 /etc/lightdm/lightdm-gtk-greeter.conf

[ -d ~/.config ] || mkdir ~/.config

[ -d ~/.config/picom ] || mkdir ~/.config/picom
cp .config/picom/picom.conf ~/.config/picom/picom.conf
chmod 644 ~/.config/picom/picom.conf

[ -d ~/.config/gtk-3.0 ] || mkdir ~/.config/gtk-3.0
cp .config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
chmod 644 ~/.config/gtk-3.0/settings.ini

[ -d ~/.config/i3 ] || mkdir ~/.config/i3
cp .config/i3/config ~/.config/i3/config
cp .config/i3/i3status.conf ~/.config/i3/i3status.conf
chmod 644 ~/.config/i3/config
chmod 644 ~/.config/i3/i3status.conf

[ -d ~/.config/rofi ] || mkdir ~/.config/rofi
cp .config/rofi/config ~/.config/rofi/config
chmod 644 ~/.config/rofi/config

[ -d ~/.config/dunst ] || mkdir ~/.config/dunst
cp .config/dunst/dunstrc ~/.config/dunst/dunstrc
chmod 644 ~/.config/dunst/dunstrc

[ -d ~/.config/kitty ] || mkdir ~/.config/kitty
cp .config/kitty/kitty.conf ~/.config/kitty/kitty.conf
chmod 644 ~/.config/kitty/kitty.conf

cp .pam_environment ~/.pam_environment
chmod 644 ~/.pam_environment

[ -d ~/.config/fish ] || mkdir ~/.config/fish
cp .config/fish/fish_variables ~/.config/fish/fish_variables
chmod 644 ~/.config/fish/fish_variables
[ -d ~/.config/fish/functions ] || mkdir ~/.config/fish/functions
cp .config/fish/functions/* .config/fish/functions/
chmod 644 .config/fish/functions/*

cp .tmux.conf ~/.tmux.conf

[ -d ~/.config/nvim ] || mkdir ~/.config/nvim
cp .config/nvim/init.vim ~/.config/nvim/init.vim
chmod 644 ~/.config/nvim/init.vim

[ -d ~/.ssh ] || mkdir ~/.ssh
cp .ssh/config ~/.ssh/config
chmod 644 ~/.ssh/config
