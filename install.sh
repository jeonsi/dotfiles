#!/bin/bash

normal=$(tput sgr0)
bold=$(tput bold)

red=$(tput setaf 1)
grn=$(tput setaf 2)
ylw=$(tput setaf 3)
gry=$(tput setaf 8)

printf "${gry}%s${normal}\n${bold}${grn}%s${normal}\n${ylw}%s${normal}\n\n" "
 █████╗ ██████╗  ██████╗██╗  ██╗    ███████╗ ██████╗ ██████╗ ███████╗███████╗████████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝╚══██╔══╝
███████║██████╔╝██║     ███████║    █████╗  ██║   ██║██████╔╝█████╗  ███████╗   ██║   
██╔══██║██╔══██╗██║     ██╔══██║    ██╔══╝  ██║   ██║██╔══██╗██╔══╝  ╚════██║   ██║   
██║  ██║██║  ██║╚██████╗██║  ██║    ██║     ╚██████╔╝██║  ██║███████╗███████║   ██║   
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝   
" \
	"ARCH FOREST INSTALLER Version 1.0" \
	"Everforest theme for Arch Linux by Arfan Zubi"

function install() {
	if [[ ! -d $HOME/.config ]]; then
		mkdir -p "$HOME/.config"
	else
		rm -rf "$HOME/.config"
	fi

    xdg-user-dirs-update

	if [[ -d $XDG_DOWNLOAD_DIR/dotfiles ]]; then
		cp -r -f "$XDG_DOWNLOAD_DIR/dotfiles/*" "$HOME/.config"

		cd "$HOME/.config" || exit 1
        echo "${ylw}Changed directory to $(pwd)${normal}"

		echo "${ylw}Removing some unnecessary files...${normal}"
		rm -rfv asus Xorg urxvt i3/i3status README.md screenshot-20221230-145517Z-all.png nvim/init.vim nvim/coc-settings.json

		echo "${ylw}Installing shell tools${normal}"
		git clone https://github.com/alexanderjeurissen/ranger_devicons "$HOME/.config/ranger/plugins/ranger_devicons"
    else
        echo "${bold}${red}dotfiles directory not found in your Downloads folder! Make sure you have xdg-user-dirs installed and run xdg-user-dirs-update!${normal}"
        exit 1
	fi
}

while true; do
	echo -e "${bold}${red}===> This installer will delete ALL files in your ~/.config directory.${normal}"
	read -r -p "${ylw}Do you want to proceed? (yes/no) ${normal}" yn

	case $yn in
	[Yy]*)
		install
		exit 0
		;;
	[Nn]*)
		echo Aborting installation...
		exit 1
		;;
	*) echo "Please answer yes or no!" ;;
	esac
done
