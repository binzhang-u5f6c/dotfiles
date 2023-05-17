# Arch Linux Installation Guide

## 1. Pre-installation

### 1.1 Prepare an installation medium

Download the Arch Linux installation [image](https://archlinux.org/download/).
Use [Rufus](https://rufus.ie) to write it to a USB stick.
Boot the live environment.

### 1.2 Connect to the internet

Ethernet is preferred.
Plug in the cable, and DHCD will work out of the box.
If not refer to [here](https://wiki.archlinux.org/index.php/Installation_guide#Connect_to_the_internet).
For WiFi refer to [here](https://wiki.archlinux.org/index.php/iwd#iwctl).

```bash
ping wiki.archlinux.org
```

Update the system clock

```bash
timedatectl set-ntp true
```

### 1.3 Partition the disks

Show all disks and partitions.

```bash
fdisk -l
```

Create a partition for `/`, a partition for `/boot` and
another partition for swap.

Format the partitions.

```bash
mkfs.fat -F 32 /dev/boot_partition
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
Install Linux, boot loader, network manager and a text editor.

```bash
pacstrap /mnt base base-devel
pacstrap /mnt linux-lts linux-firmware
pacstrap /mnt grub efibootmgr
pacstrap /mnt networkmanager neovim
```

Install CPU microcode according to your CPU.

```bash
pacstrap /mnt intel-ucode
pacstrap /mnt amd-ucode
```

### 2.2 Configure the system

Generate a fstab file.

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

Set the Hardware Clock as local time.

```bash
hwclock --systohc --localtime
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

Enable the network manager daemon.

```bash
systemctl enable NetworkManager.service
```

### 2.3 User management

Set the root password.

```bash
passwd
```

Add a new user account and set its password.

```bash
useradd -m -G wheel name
passwd name
```

Edit `/etc/sudoers` via `EDITOR=nvim visudo`.
Comment out the line `%wheel ALL=(ALL) ALL` to
make the new user access to `sudo`.

### 2.4 Boot loader

Install the GRUB and generate the configuration file.

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

Exit the chroot environment. Unmount all the partitions.

```bash
umount -R /mnt
```

Reboot.

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
pacman -S python python-pip
pacman -S nodejs npm yarn
pacman -S perl ruby go
```

Install download tools.
(Git is a version control system but it is often used as a download tool.)

```bash
pacman -S git
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
yay -S xorg-server xorg-apps
```

Install video driver.

```bash
yay -S nvidia-lts nvidia-utils
yay -S xf86-video-amdgpu mesa
```

Install KDE desktop environment.

```bash
yay -S plasma sddm
systemctl enable sddm.service
yay -S kde-system-meta
yay -S kde-utilities-meta
yay -S kde-graphics-meta
```

Install clipboard.

```bash
yay -S xclip
```

Install fonts.

```bash
yay -S noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
yay -S ttf-nerd-fonts-symbols-2048-em ttf-nerd-fonts-symbols-2048-em-mono
```

### 3.3 Install utilities and softwares

```bash
yay -S man-db man-pages
yay -S p7zip openssh wget
yay -S rsync rclone
yay -S fcitx5-im fcitx5-chinese-addons
yay -S keepassxc goldendict vlc chromium
```

Generate ssh key,

```bash
ssh-keygen -t rsa -b 4096 -C "your_email"
```

and add your public key to Github. Add the following to `~/.ssh/config`.

```plain
Host *
    ServerAliveInterval 60
```

## 4. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
chmod 755 install.sh
./install.sh
cd
```

## 5. Configure development environment

Install development utilities.

```bash
yay -S fd ripgrep fzf tmux
```

### 5.1 Configure neovim

Change npm's default directory.

```bash
npm config set prefix '~/.local'
```

Install python/nodejs providers of neovim.

```bash
pip install --user pynvim
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

### 5.2 Install LSP

Install clang.

```bash
yay -S llvm clang
```

Install python language server.

```bash
pip install --user python-lsp-server[all]
```

Install bash language server.

```bash
npm install -g bash-language-server
```

Install markdown linter.

```bash
npm install -g markdownlint-cli
```

## 6. Download blogs

Install hugo for static site generation.

```bash
yay -S hugo
```

Download blogs repository.

```bash
git clone git@github.com:binzhang-u5f6c/binzhang-u5f6c.github.io.git Blogs
cd Blogs
git submodule init
git submodule update
```

Generate the site.

```bash
hugo
hugo server
```
