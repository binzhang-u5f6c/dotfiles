# Developing on ArchWSL

## 1. Install essential softwares

Install essential softwares after Windows 10 installation.

* [Chrome](https://www.google.com/intl/zh-CN/chrome/)
* [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* [7zip](https://www.7-zip.org)
* [keepassxc](https://keepassxc.org)
* [goldendict](https://www.github.com/goldendict/goldendict)
* [potplayer](https://potplayer.daum.net)

## 2. Install ArchWSL

### 2.1. Enable the WSL feature

Open PowerShell as Administrator and run.

```PS
dism.exe /online /enable-feature `
/featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### 2.2. Install ArchWSL

Download [ArchWSL](https://github.com/yuk7/ArchWSL).
Run `Arch.exe` to extract rootfs and register to WSL.

### 2.3. User management

Set root password via `passwd`.
Add user and set user's password.

```bash
useradd -m -G wheel your_name
passwd your_name
```

Set vim as the default editor of `visudo`.

```bash
SUDO_EDITOR=vim
```

Edit `/etc/sudoer` via `visudo` and comment out the line
`%wheel ALL=(ALL) ALL` to make new user access to `sudo`.

Set up the default user.

```PS
Arch.exe config --default-user your_name
```

### 2.4. Update to WSL2

Open PowerShell as Administrator and
enable the Virtual Machine Platform feature

```PS
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform `
/all /norestart
```

Download the
[Linux kernel update package](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)
and install.
Set the ArchWSL to WSL2.

```PS
wsl --set-version Arch 2
wsl --list --verbose
```

### 2.5. Install WSLtty as terminal emulator

[Download](https://github.com/mintty/wsltty) and install.
The color theme files are in `AppData/Local/wsltty/usr/share/mintty/themes`.
Add the solarized light theme.

```plain
Black=#eee8d5
Red=#dc322f
Green=#859900
Yellow=#b58900
Blue=#268bd2
Magenta=#d33682
Cyan=#2aa198
White=#073642
BoldBlack=#fdf6e3
BoldRed=#cb4b16
BoldGreen=#93a1a1
BoldYellow=#839496
BoldBlue=#657b83
BoldMagenta=#6c71c4
BoldCyan=#586e75
BoldWhite=#002b36
```

Set the Foreground, Background and Cursor as
`101,123,131`, `253,246,227` and `88,110,117` respectively.

### 2.6. Install utilities

Move the proper mirrors to the top in `/etc/pacman.d/mirrorlist`.
Initialize keyring.

```bash
pacman-key --init
pacman-key --populate
```

Update the system.

```bash
pacman -Syu
```

Then install the essential packages.

```bash
pacman -S base base-devel
pacman -S man-db man-pages
pacman -S fd ripgrep fzf rsync
pacman -S p7zip git openssh imagemagick
```

Set your git user name and email address.

```bash
git config --global user.name "your_name"
git config --global user.email your_email
```

Add following content to `~/.ssh/config`.

```plain
Host *
    ServerAliveInterval 60
```

Generate ssh key,

```bash
ssh-keygen -t rsa -b 4096 -C "your_email"
```

and add your public key to Github.

### 2.7. Install package manager

Install `yay`.

```bash
pacman -S go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

Comment out the lines in `/etc/pacman.conf` to enable multilib repository.

```plain
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Update via `yay`.

## 3. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
chmod 755 install.sh
./install.sh
cd
```

## 4. Configure development environment

### 4.1. Install programming languages

```bash
yay -S python python2 python-pip
yay -S nodejs npm yarn
```

### 4.2. Install Jupyter and data science packages

```bash
pip install jupyterlab
pip install jupyter-lsp
pip install python-language-server[all]
jupyter labextension install jupyterlab-drawio
jupyter labextension install @jupyterlab/toc
jupyter labextension install @arbennett/base16-solarized-light
jupyter labextension install @krassowski/jupyterlab-lsp
pip install pandas numpy scipy matplotlib sklearn
```

### 4.3. Install and configure neovim

```bash
yay -S neovim python-pynvim xclip
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.config/nvim/plugins
nvim .config/nvim/init.vim
```

Install vim plugins via `:PlugInstall` in neovim.

### 4.4. Download blogs and gems

Install Ruby and bundler.

```bash
yay -S ruby
gem install bundler
bundle config path ~/.gem
```

Clone blogs repository and install gems.

```bash
mkdir Studio
git clone git@github.com:binzhang-u5f6c/binzhang-u5f6c.github.io.git Studio/00.Blogs
cd Studio/00.Blogs
bundle install
```
