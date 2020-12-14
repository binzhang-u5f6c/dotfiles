# Developing on ArchWSL

[[toc]]

## 1. Install essential softwares

Install essential softwares after Windows 10 installation.

* [7zip](https://www.7-zip.org)
* [keepassxc](https://keepassxc.org)
* [goldendict](https://www.github.com/goldendict/goldendict/wiki/Early-Access-Builds-for-Windows)
* [ccleaner](https://www.ccleaner.org)
* [potplayer](https://potplayer.daum.net)

## 2. Install ArchWSL

Open PowerShell as Administrator and enable the WSL feature.

```PS
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

Download [ArchWSL](https://github.com/yuk7/ArchWSL).
Run `Arch.exe` to extract rootfs and register to WSL.
Run `Arch.exe` again and set root password via `passwd`.
Add user and set user's password.

```bash
useradd -m -G wheel your_name
passwd your_name
```

Edit `/etc/sudoer` via `EDITOR=vim visudo` and comment out the line
`%wheel ALL=(ALL) ALL` to make new user access to `sudo`.
Exit the system and set up the default user.

```PS
Arch.exe config --default-user your_name
```

Open PowerShell as Administrator and
enable the Virtual Machine Platform feature.

```PS
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

[Download](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)
and install Linux kernel update package.
Set the ArchWSL to WSL2 after restarting.

```PS
wsl --set-version Arch 2
wsl --list --verbose
```

[Download](https://github.com/mintty/wsltty) and install WSLtty.
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

## 3. Install utilities and softwares in ArchWSL

Move the proper mirrors to the top in `/etc/pacman.d/mirrorlist`.
Initialize keyring.

```bash
pacman-key --init
pacman-key --populate
```

Update and install basic system.

```bash
pacman -Syu
pacman -S base base-devel
pacman -S man-db man-pages
```

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

Install other softwares.

```bash
yay -S p7zip openssh rsync
yay -S ripgrep fzf
```

Add following content to `~/.ssh/config`.

```plain
Host *
    ServerAliveInterval 60
```

Generate ssh key.

```bash
ssh-keygen -t rsa -b 4096 -C "your_email"
```

Add your public key to Github.

## 4. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
chmod 755 install.sh
./install.sh
cd
```

## 5. Configure development environment

### 5.1. Install and configure neovim

Install neovim.

```bash
yay -S neovim
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

Use `:PlugInstall` in neovim to install plugins.

### 5.2. Install and configure Jupyter

Install Jupyter lab and some extensions.

```bash
pip install jupyterlab
pip install ipywidgets
pip install jupyter-lsp
jupyter labextension install @jupyterlab/toc --no-build
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install @arbennett/base16-solarized-light --no-build
jupyter labextension install @krassowski/jupyterlab-lsp --no-build
jupyter labextension install jupyterlab-drawio --no-build
jupyter lab build
```

Install some data science packages.

```bash
pip install numpy scipy matplotlib
pip install pandas scikit-learn scikit-multiflow
```

### 5.3. Install LSP

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
git clone git@github.com:binzhang-u5f6c/binzhang-u5f6c.github.io.source.git ~/Site

cd ~/Site
git submodule init
git submodule update
```

Generate the site.

```bash
hugo
hugo server
```
