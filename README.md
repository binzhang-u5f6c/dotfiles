# Developing on ArchWSL

## 1. Install essential softwares

Install essential softwares after Windows 10 installation.

* [7zip](https://www.7-zip.org)
* [keepassxc](https://keepassxc.org)
* [goldendict](https://www.github.com/goldendict/goldendict/wiki/Early-Access-Builds-for-Windows)
* [vlc](https://www.videolan.org)

## 2. Install ArchWSL

Open PowerShell as Administrator and install WSL.

```PS
wsl --install
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
pacman -Sy archlinux-keyring && pacman -Syu
pacman -S base base-devel
```

Install some programming languages which are dependencies
of many useful tools.

```bash
pacman -S python python-pip
pacman -S nodejs npm yarn
```

Install utilities and config git.

```bash
pacman -S man-db man-pages
pacman -S p7zip openssh git wget rsync
git config --global user.name "your_name"
git config --global user.email your_email
```

Generate ssh key,

```bash
ssh-keygen -t rsa -b 4096 -C "your_email"
```

and add your public key to Github.

Add following content to `~/.ssh/config`.

```plain
Host *
    ServerAliveInterval 60
```


## 4. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
git checkout wsl
chmod 755 install.sh
./install.sh
cd
```

## 5. Configure development environment

Install development utilities.

```bash
pacman -S fd ripgrep fzf tmux
```

### 5.1. Install and configure neovim

Change npm's default directory.

```bash
npm config set prefix '~/.local'
```

Install neovim and python/nodejs/ruby providers of neovim.

```bash
pacman -Rsc vim
pacman -S neovim
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

Use `:PlugInstall` in neovim to install plugins.

### 5.2 Install Jupyter lab and some extensions

```bash
pip install --user jupyterlab
jupyter labextension install --no-build @jupyterlab/toc
jupyter labextension install --no-build @arbennett/base16-solarized-light
jupyter lab build
```

Create a virtual environment, register an iPython kernel,
and install data science packages.

```bash
mkdir Virtualenv
python -m venv Virtualenv
source VirtualEnv/bin/activate
pip install pynvim ipykernel
python -m ipykernel install --user --name name
pip install python-language-server[all]
pip install numpy scipy matplotlib
pip install pandas scikit-learn scikit-multiflow
```
