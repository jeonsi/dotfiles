# Arch Linux Everforest Ricing

This is a straight-forward guide for ricing Arch Linux with the [Everforest](https://github.com/sainnhe/everforest) colorscheme theme.

I use a minimal install of Arch Linux on UTM (QEMU virtual machine) on a Macbook Air M1 (2020). This guide should also work with the new Macbook Air M2 and the Pro versions.

## Installation

ℹ️ For help with the installation process watch my video: https://www.youtube.com/watch?v=cOobSmI-XgA&t=399s

### Console keyboard layout

Find out which keyboard layout you are using and then set it using `loadkeys`:

```
$ ls /usr/share/kbd/keymaps/**/*.map.gz
$ loadkeys de_CH-latin1
```

### Partitioning

Check the name of the hard disk:

```
fdisk -l
```

Use the name (in my case _vda_) to start the `fdisk` partitioning tool:

```
fdisk /dev/vda
```

Press <kbd>g</kbd> to create a new GPT Partition Table.

We will do it according to the example layout of the Arch wiki:

| Mount point | Partition                   | Partition type | Suggested size      |
| ----------- | --------------------------- | -------------- | ------------------- |
| /mnt/boot   | /dev/_efi_system_partition_ | uefi           | At least 300 MiB    |
| [SWAP]      | /dev/_swap_partition_       | swap           | More than 512 MiB   |
| /mnt        | /dev/_root_partition_       | linux          | Remainder of device |

#### Create boot partition

1. Press <kbd>n</kbd>.
2. Press <kbd>Enter</kbd> to use the default first sector.
3. Enter _+300M_ for the last sector.
4. Press <kbd>t</kbd> and choose 1 and write _uefi_.

#### Create swap partition

1. Press <kbd>n</kbd>.
2. Press <kbd>Enter</kbd> to use the default first sector.
3. Enter _+512M_ for the last sector.
4. Press <kbd>t</kbd> and choose 2 and write _swap_.

#### Create root partition

1. Press <kbd>n</kbd>.
2. Press <kbd>Enter</kbd> to use the default first sector.
3. Enter <kbd>Enter</kbd> to use the default last sector.
4. Press <kbd>t</kbd> and choose 3 and write _linux_.

**When you are done partitioning don't forget to press <kbd>w</kbd> to save the changes!**

After partitioning check if the partitions have been created using `fdisk -l`.

### Partition formatting

```
$ mkfs.ext4 /dev/root_partition
$ mkswap /dev/swap_partition
$ mkfs.fat -F 32 /dev/efi_system_partition
```

### Mounting the file system

```
$ mount /dev/root_partition /mnt
$ mount --mkdir /dev/efi_system_partition /mnt/boot
$ swapon /dev/swap_partition
```

### Package install

For a minimal system download and install these packages:

```
$ pacstrap -K /mnt base base-devel linux linux-firmware e2fsprogs dhcpcd networkmanager sof-firmware git neovim man-db man-pages texinfo
```

⚠️ If you get errors due to key then do the following:

1. Initialize _pacman_ keys and populate them:

```
pacman-key --init
pacman-key --populate
```

2. Synchronize Arch keyring:

```
archlinux-keyring-wkd-sync
```

### Last steps

#### Generate fstab file

```
$ genfstab -U /mnt >> /mnt/etc/fstab
```

#### Change root into new system

```
$ arch-chroot /mnt
```

#### Set time zone

```
$ ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
$ hwclock --systohc
```

#### Localization

Edit _/etc/locale.gen_ and uncomment _en_US.UTF-8 UTF-8_ and other needed locales. Generate the locales by running:

```
$ locale-gen
```

Create _/etc/locale.conf_ and set the _LANG_ variable according to your preferred language:

```
LANG=de_CH.UTF-8
```

Create _/etc/vconsole.conf_ and set the following variables according to your preferred language:

```
KEYMAP=de_CH-latin1
FONT=Lat2-Terminus16
```

#### Network configurations

Create _/etc/hostname_ and type any name you wish as your hostname:

```
arch
```

Edit _/etc/hosts_ like this:

```
127.0.0.1 localhost
::1 localhost
127.0.1.1 arch (your host name here!)
```

#### Initramfs

```
$ mkinitcpio -P
```

#### Root password

Set a new password for root:

```
$ passwd
```

#### Bootloader

Install `grub` and `efibootmgr`:

```
$ pacman -S grub efibootmgr
```

Run the following command:

```
$ grub-install --efi-directory=/boot --bootloader-id=GRUB
```

Then create a **GRUB** config file:

```
$ grub-mkconfig -o /boot/grub/grub.cfg
```

#### Final step

Exit out of the chroot environment by typing `exit` or pressing <kbd>Ctrl</kbd>+<kbd>d</kbd>.

Unmount all the partitions:

```
$ umount -R /mnt
```

Then type `poweroff` and remove the installation disk from the virtual machine.

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

### SPICE support on guest

This will enhance graphics and improve support for multiple monitors or clipboard sharing.

```
$ sudo pacman -S spice-vdagent xf86-video-qxl
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
$ sudo pacman -S openssh
$ sudo pacman -S iw wpa_supplicant
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

### Enable Time Synchronization

```
$ sudo systemctl enable systemd-timesync
```

Then enable NTP:

```
$ timedatectl set-ntp true
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

After installing X and i3 create a file **.xinitrc** in your home directory with the following content:

```
exec i3
```

This way you can start the X server with the command `startx`.

### Drivers

If running outside UMT we need drivers:

**Intel**:

```
sudo pacman -S mesa xf86-video-qxl intel-media-driver
```

**NVIDIA**:

```
sudo pacman -S libva-mesa-driver
```

### Compositor

```
$ sudo pacman -S picom
```

### Font

```
$ sudo pacman -S noto-fonts noto-fonts-emoji
```

```
$ yay -S nerd-fonts-complete
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
$ sudo pacman -S rxvt-unicode alacritty kitty
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

For previews we also need **feh** and **Überzug**:

```
$ sudo pacman -S feh ueberzug
```

### Browser

```
$ sudo pacman -S firefox
```

### Media Player

```
$ sudo pacman -S vlc
```

### PDF Viewer

```
$ sudo pacman -S zathura
```

### Wallpapers

Check these amazing wallpapers that harmonize with the Everforest theme: https://github.com/Apeiros-46B/everforest-walls

### Other Tools

```
$ sudo pacman -S bat fzf fd ripgrep lsd tree htop nodejs npm yarn wget neofetch
```

What you also will need:

- [Packer](https://github.com/wbthomason/packer.nvim)
- [icons-in-terminal](https://github.com/sebastiencs/icons-in-terminal)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [ranger_devicons](https://github.com/alexanderjeurissen/ranger_devicons)
