#!/bin/bash

normal=$(tput sgr0)
bold=$(tput bold)

red=$(tput setaf 1)
grn=$(tput setaf 2)
ylw=$(tput setaf 3)
gry=$(tput setaf 8)

CONFIG_DIR=$HOME/.config
DOWNLOADS=$XDG_DOWNLOAD_DIR

printf "${gry}%s${normal}\n${bold}${grn}%s${normal}\n${ylw}%s${normal}\n\n" "

███████╗██╗   ██╗███████╗██████╗ ███████╗ ██████╗ ██████╗ ███████╗███████╗████████╗
██╔════╝██║   ██║██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝╚══██╔══╝
█████╗  ██║   ██║█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝█████╗  ███████╗   ██║   
██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██╔══╝  ╚════██║   ██║   
███████╗ ╚████╔╝ ███████╗██║  ██║██║     ╚██████╔╝██║  ██║███████╗███████║   ██║   
╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝   

" \
	"EVERFOREST THEME FOR ARCH LINUX Version 1.0" \
	"Author: Arfan Zubi" \
    "License: GNU General Public License"

# Installer
function install() {
	if [[ -d "$CONFIG_DIR" ]]; then
		echo "${ylw}$CONFIG_DIR does already exist, deleting all files...${normal}"
		rm -rfv "$HOME/.config"
	fi

	echo "${ylw}Creating new $CONFIG_DIR directory...${normal}"
	mkdir -p "$HOME/.config"

	echo "${ylw}Creating XDG user directories...${normal}"
	xdg-user-dirs-update
	echo "${ylw}Done!${normal}"

	if [[ -d $DOWNLOADS ]]; then
        echo "${ylw}Copying files from ${DOWNLOADS} to ${CONFIG_DIR}${normal}"
		cp -a "$DOWNLOADS/dotfiles/." "$HOME/.config"
        cp -a "$DOWNLOADS/dotfiles/Xorg/." "/etc/X11/xorg.conf.d"

		cd "$HOME/.config" || exit 1
		echo "${ylw}Changed directory to $(pwd)${normal}"

		echo "${ylw}Removing some unnecessary files...${normal}"
		rm -rfv asus Xorg urxvt i3/i3status screenshot-20221230-145517Z-all.png nvim/init.vim nvim/coc-settings.json install.sh

		echo "${ylw}Installing shell tools${normal}"
		git clone --depth 1 https://github.com/wbthomason/packer.nvim "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
		git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
		git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"

		git clone https://github.com/sebastiencs/icons-in-terminal.git "/usr/share"

		if [[ -d /usr/share/icons-in-terminal ]]; then
			sudo /usr/share/icons-in-terminal/install.sh
		fi

	else
        echo "${bold}${red}dotfiles directory not found in your Downloads folder! Make sure you cloned the dotfiles (git clone https://github.com/3rfaan/dotfiles.git) and you have xdg-user-dirs installed and run xdg-user-dirs-update!${normal}"
		exit 1
	fi
}

# Removing install files after moving them to .config
function rm_install_file() {
	if [[ -d $DOWNLOADS/dotfiles ]]; then
		echo "${ylw}Removing installation files...${normal}"
		rm -rf "$DOWNLOADS/dotfiles"
	fi
}

while true; do
	echo -e "${bold}${red}===> This installer will delete ALL files in your ~/.config directory.${normal}"
	read -r -p "${ylw}Do you want to proceed? [y/N] ${normal}" yn

	case $yn in
	[Yy]*)
		install
		rm_install_file
		exit 0
		;;
	[Nn]*)
		echo Aborting installation...
		exit 1
		;;
	*) echo "Please answer yes or no!" ;;
	esac
done
