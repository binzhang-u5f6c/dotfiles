# Arch Linux Installation Guide

## 1. Pre-installation

### 1.1 Prepare an installation medium

Download the Arch Linux installation [image](https://archlinux.org/download/).
Use [Rufus](https://rufus.ie) to write it to a USB stick.
Boot the live environment.

### 1.2 Connect to the internet

If the internet is not connected, check the network interface firstly.

```bash
ip link
```

Ethernet is preferred.
Plug in the cable, and DHCD will work out of the box.
For WiFi refer to [iwctl](https://wiki.archlinux.org/index.php/iwd#iwctl).

### 1.3 Update the system clock

```bash
timedatectl set-ntp true
```

### 1.4 Partition the disks

Show all disks and partitions.

```bash
fdisk -l
```

Create a partition for `/`, a partition for `/boot` and
another partition for swap.

Format the partitions.

```bash
mkfs.ext4 /dev/root_partition
mkswap /dev/swap_partition
```

Mount the file systems.

```bash
mount /dev/root_partition /mnt
mkdir /mnt/boot
mount /dev/boot_partition /mnt/boot

swapon /dev/swap_partition
```

## 2. Install basic Linux and configure the system

### 2.1 Install basic Linux

Select proper mirrors in `/etc/pacman.d/mirrorlist`.
Install Linux, network manager and a text editor.

```bash
pacstrap /mnt base base-devel
pacstrap /mnt linux linux-firmware
pacstrap /mnt networkmanager vim
```

Install CPU microcode according to your CPU.

```bash
pacstrap /mnt intel-ucode amd-ucode
```

### 2.2 Configure the system

Generate an fstab file.

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Change root into the system.

```bash
arch-chroot /mnt
```

Set the time zone.

```bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Edit `/etc/locale.gen` and uncomment `en_US.UTF-8`.
Generate the locales.

```bash
locale-gen
```

Create the hostname file `/etc/hostname`.

```plain
hostname
```

Add matching entries to `/etc/hosts`.

```plain
127.0.0.1     localhost
::1           localhost
127.0.1.1     hostname.localdomain hostname
```

### 2.3 Configure the network

Enable the network manager daemon.

```bash
systemctl enable NetworkManager.service
```

Synchronize the system clock.

```bash
timedatectl set-ntp true
hwclock --systohc --local
```

### 2.4 User management

Set the root password.

```bash
passwd
```

Add a new user account and set its password.

```bash
useradd -m -G wheel name
passwd name
```

Edit `/etc/sudoers` via `visudo`.
Comment out the line `%wheel ALL=(ALL) ALL` to make the new user access to
`sudo`.

### 2.5 Add boot entry

Exit the chroot environment. Unmount all the partitions.

```bash
umount -R /mnt
```

Reboot the machine to UEFI shell,
which is accessed in Arch Linux installation image.
Create a boot entry for Arch Linux.

```plain
map
ls FS0:
bcfg boot dump
bcfg boot add N FS0:\vmlinuz-linux "Arch Linux"
```

Create a text file.

```plain
edit FS0:\options.txt
```

Write following kernel options into it.

```plain
root=/dev/root_partition initrd=\cpu_manufacturer-ucode.img initrd=\initramfs-linux.img
```

Press `F2` to save and `F3` to exit.
Add the option file to the boot entry.

```plain
bcfg boot -opt N FS0:\options.txt
```

Remove the boot entry when necessary.

```plain
bcfg boot rm N
```

## 3. Post-installation

Reboot and log in as the new user account.

Select proper mirrors in `/etc/pacman.d/mirrorlist`.
Update the system.

```bash
pacman -Syu
```

### 3.1 Package Management

Install some programming languages which may be needed when making packages.

```bash
pacman -S perl python ruby go
```

Install download tools.
(Git is a version control system but it is often used as a download tool.)

```bash
pacman -S git wget
git config --global user.name "your_name"
git config --global user.email your_email
```

Install yay for package management of Arch User Repository.

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
yay
```

### 3.2 Install graphical user interface

Install Xorg.

```bash
yay -S xorg
```

Install Nvidia driver.

```bash
yay -S nvidia nvidia-utils
```

Install windows manager, display manager and terminal emulator.

```bash
yay -S qtile
yay -S lightdm lightdm-gtk-greeter light-locker
systemctl enable lightdm.service
yay -S termite
```

Install fonts.

```bash
yay -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
yay -S ttf-nerd-fonts-symbols
```

### 3.3 Install sound server

Install Pulse Audio and its GUI frontend.

```bash
yay -S pulseaudio pavucontrol
```

### 3.4 Install imput methods

Install fcitx and pinyin input methods.

```bash
yay -S fcitx-im fcitx-configtool
yay -S fcitx-googlepinyin fcitx-cloudpinyin
```

### 3.5 Install system trays

Install system trays for battery, network and audio.

```bash
yay -S cbatticon network-manager-applet pa-applet-git
```

### 3.6 Install utilities and softwares

```bash
yay -S man-db man-pages
yay -S p7zip openssh
yay -S rsync rclone
yay -S ripgrep fzf
yay -S imagemagick feh
yay -S keepassxc goldendict
yay -S zathura zathura-pdf-mupdf zathura-djvu
yay -S firefox vlc
```

Add the following to `~/.ssh/config`.

```plain
Host *
    ServerAliveInterval 60
```

Generate ssh key,

```bash
ssh-keygen -t rsa -b 4096 -C "your_email"
```

and add your public key to Github.

## 4. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
chmod 755 install.sh
./install.sh
cd
```

## 5. Configure development environment

### 5.1 Install and configure neovim

Install neovim and its python/nodejs providers.

```bash
yay -S neovim xclip
yay -S python-pip
pip install pynvim
yay -S nodejs npm yarn
npm install -g neovim
```

Install neovim plugins.

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.config/nvim/plugins
nvim .config/nvim/init.vim
```

Use `:PlugInstall` in neovim to install vim plugins.

### 5.2 Install Jupyter lab and some extensions

```bash
pip install jupyterlab
pip install jupyter-lsp
jupyter labextension install @jupyterlab/toc
jupyter labextension install @arbennett/base16-solarized-light
jupyter labextension install jupyterlab-drawio
jupyter labextension install @krassowski/jupyterlab-lsp
```

Create a virtual environment, register an iPython kernel,
and install data science packages.

```bash
python -m venv .data.science.venv
source .data.science.venv/bin/activate
pip install ipykernel
python -m ipykernel install --name name
pip install numpy scipy matplotlib
pip install pandas scikit-learn scikit-multiflow
```

### 5.3 Install LSP

Install markdown linter.

```bash
npm install -g markdownlint-cli
```

Install bash language server.

```bash
npm install -g bash-language-server
```

Install ccls.

```bash
yay -S ccls
```

Install python language server.

```bash
pip install python-language-server[all]
```

## 6. Download blogs

Install hugo for static site generation.

```bash
yay -S hugo
```

Download blogs repository.

```bash
mkdir Studio
git clone git@github.com:binzhang-u5f6c/binzhang-u5f6c.github.io.source.git Studio/00.Site

cd Studio/00.Site
git submodule init
git submodule update
```

Generate the site.

```bash
hugo
hugo server
```
