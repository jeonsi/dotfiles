# Arch Linux Everforest Ricing

This is a straight-forward guide for ricing Arch Linux with the [Everforest](https://github.com/sainnhe/everforest) colorscheme theme.

I use a minimal install of Arch Linux on UTM (QEMU virtual machine) on a Macbook Air M1 (2020). This guide should also work with the new Macbook Air M2 and the Pro versions.

## Installation

For help with the installation process watch my video: ...

## System-related Configurations

### Update the system

First things first: Update the system!

```
$ pacman -Syu
```

### `sudo` Command

```
$ pacman -S sudo
```


### Add your personal user account

```
$ useradd -m -g users -G wheel,storage,power,audio <your username>
$ passwd <your username> <your password>
```

#### Grant root access to our user

```
$ EDITOR=vim visudo
```

Uncomment the following line:

```
%wheel ALL=(ALL) NOPASSWD: ALL
```

You can then login as your newly created user:

```
$ su <your username>
```

If you wish to have the default XDG directories (like Downloads, Pictures, Documents etc.) do:

```
$ sudo pacman -S xdg-user-dirs
$ xdg-user-dirs-update
```

### Install AUR package manager

To install [yay](https://github.com/Jguer/yay):

```
$ sudo pacman -S base-devel git
$ mkdir aur
$ cd aur
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si
```

### Sound

```
$ sudo pacman -S pulseaudio
$ sudo pacman -S alsa-utils alsa-plugins
$ sudo pacman -S pavucontrol
```

PulseAudio Applet:

```
$ yay -S pa-applet-git
```

### Network

```
$ sudo pacman -S iw wpa_supplicant
$ sudo pacman -S dhcpcd networkmanager 
```

NetworkManager Applet:

```
$ sudo pacman -S network-manager-applet
```

Enable SSH, DHCP and NM:

```
$ sudo systemctl enable sshd
$ sudo systemctl enable dhcpcd
$ sudo systemctl enable NetworkManager
```

### Bluetooth

```
$ sudo pacman -S bluez bluez-utils blueman
$ sudo systemctl enable bluetooth
```

### Pacman

To beautify Pacman use:

```
$ sudo vim /etc/pacman.conf
```

Uncomment `Color` and add below it `ILoveCandy`.

### Enable SSD Trim

```
$ sudo systemctl enable fstrim.timer
```

## Graphical User Interface (GUI) Settings

### Xorg

```
$ sudo pacman -S xorg-server xorg-apps xorg-xinit xclip
```

### i3

```
$ sudo pacman -S i3
```

### Compositor

```
$ sudo pacman -S picom
```

### Font

```
$ sudo pacman -S noto-fonts
```

```
$ yay -S nerd-fonts-fira-code
```

### Shell

```
$ sudo pacman -S zsh
```

Change default shell to zsh:

```
$ chsh -s $(which zsh)
```

### Terminal

```
$ sudo pacman -S rxvt-unicode
```

### Editor

```
$ sudo pacman -S neovim
```

### Switcher

```
$ sudo pacman -S dmenu rofi 
```

### Status Bar

```
$ sudo pacman -S polybar
```

### File Manager

```
$ sudo pacman -S ranger
```

### Browser

```
$ sudo pacman -S firefox
```

### Media Player

```
$ sudo pacman -S vlc
```

### Other Tools

```
$ sudo pacman -S bat fzf htop nodejs npm yarn openssh wget
```
