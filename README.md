# Developing on ArchWSL

## 1. Install essential softwares

Install essential softwares after Windows 10 installation.

* [Chrome](https://www.google.com/intl/zh-CN/chrome/)
* [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* [7zip](https://www.7-zip.org)
* [keepassxc](https://keepassxc.org)
* [goldendict](https://www.github.com/goldendict/goldendict)
* [potplayer](https://potplayer.daum.net)

## 2. Install Python and data science toolkit

[Download](https://python.org/downloads/) and install Python.
Python 3.7 is the latest security fix release by now.

Install Jupyter Lab with some awesome extensions.
[Download](https://nodejs.org/en/download/) and install Node.js
which is required by jupyter-lsp.

```bash
pip install jupyterlab
pip install jupyter-lsp
pip install python-language-server[all]
jupyter labextension install jupyterlab-drawio
jupyter labextension install @jupyterlab/toc
jupyter labextension install @arbennett/base16-solarized-light
jupyter labextension install @krassowski/jupyterlab-lsp
```

**Note**: you may encounter error while installing extensions.
Modifying `Python37\Lib\site-packages\jupyterlab\commands.py`
can fix the bug.

```python
self.proc = self._create_process(
    cwd=cwd,
    env=env,
    stderr=subprocess.STDOUT,
    stdout=subprocess.PIPE,
    universal_newlines=True,
    # add the following line
    encoding="UTF-8"
)
```

Install essential data science packages.

```bash
pip install numpy scipy matplotlib
pip install pandas scikit-learn scikit-multiflow
```

## 3. Install ArchWSL

### 3.1. Enable the WSL feature

Open PowerShell as Administrator and run.

```PS
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### 3.2. Install ArchWSL

Download [ArchWSL](https://github.com/yuk7/ArchWSL).
Run `Arch.exe` to extract rootfs and register to WSL.

### 3.3. User management

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

### 3.4. Update to WSL2

Open PowerShell as Administrator and
enable the Virtual Machine Platform feature

```PS
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

[Download](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)
and install Linux kernel update package.
Set the ArchWSL to WSL2.

```PS
wsl --set-version Arch 2
wsl --list --verbose
```

### 3.5. Install WSLtty as terminal emulator

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

### 3.6. Install utilities

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
pacman -S base base-devel gcc-go
pacman -S man-db man-pages
pacman -S wget openssh
pacman -S p7zip rsync
pacman -S ripgrep fzf
pacman -S git imagemagick
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

### 3.7. Install package manager

Install `yay`.

```bash
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

## 4. Download the dotfiles

```bash
git clone git@github.com:binzhang-u5f6c/dotfiles.git .dotfiles
cd .dotfiles
chmod 755 install.sh
./install.sh
cd
```

## 5. Configure development environment

### 5.1. Install programming languages

```bash
yay -S nodejs npm yarn
yay -S ruby python
```

### 5.2. Install and configure neovim

```bash
yay -S neovim python-pynvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.config/nvim/plugins
nvim .config/nvim/init.vim
```

Install vim plugins via `:PlugInstall` in neovim.

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
git submodule add https://github.com/koirand/pulp.git themes/pulp
git submodule add git@github.com:binzhang-u5f6c/binzhang-u5f6c.github.io.git public
```

Generate the site.

```bash
hugo
hugo server
```
