#!/bin/bash

# Formatting
normal=$(tput sgr0)
bold=$(tput bold)

red=$(tput setaf 1)
grn=$(tput setaf 2)
ylw=$(tput setaf 3)
gry=$(tput setaf 8)

# Command line arguments
system=$1

# Directories
CONFIG_DIR=$HOME/.config
DOWNLOAD_DIR=$HOME/Downloads

# Header
printf "${gry}%s${normal}\n${bold}${grn}%s${normal}\n${bold}${ylw}%s${normal}\n${ylw}%s${normal}\n${gry}%s${normal}\n\n" "

███████╗██╗   ██╗███████╗██████╗ ███████╗ ██████╗ ██████╗ ███████╗███████╗████████╗
██╔════╝██║   ██║██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝╚══██╔══╝
█████╗  ██║   ██║█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝█████╗  ███████╗   ██║   
██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██╔══╝  ╚════██║   ██║   
███████╗ ╚████╔╝ ███████╗██║  ██║██║     ╚██████╔╝██║  ██║███████╗███████║   ██║   
╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝   

" \
	"EVERFOREST CONFIGS FOR ARCH LINUX Version 2.0" \
	"Author: Arfan Zubi" \
	"Theme: Sainnhe Park" \
	"License: 2023 GNU General Public License"

# Installation prompt
function main() {
	while true; do
		echo -e "${bold}${red}===> This installer will delete ALL files in your ~/.config directory.${normal}"
		read -r -p "${ylw}Do you want to proceed? [y/N] ${normal}" yn

		case $yn in
		[Yy]*)
			pre_install_checks
			remove_git_directory
			copy_config_files
			copy_others
			set_wallpaper
			install_shell_tools
			remove_install_file

			echo "${bold}${grn}Installation succeeded! Exiting...${normal}"
			exit 0
			;;
		[Nn]* | "")
			echo "${bold}${red}Aborting installation...${normal}"
			exit 1
			;;
		*) echo "Please enter [y]es or [n]o!" ;;
		esac
	done
}

# Checking if ~/.config already exists and wipe it if it does
function pre_install_checks() {
	if [[ -d "$CONFIG_DIR" ]]; then
		echo "${ylw}$CONFIG_DIR does already exist, deleting all files...${normal}"
		rm -rfv "$CONFIG_DIR"
	else
		echo "${ylw}Creating new config directory ($CONFIG_DIR)${normal}"
	fi

	# Creating new empty ~/.config
	echo "${ylw}Creating new $CONFIG_DIR directory...${normal}"
	mkdir -p "$CONFIG_DIR" || {
		echo "${bold}${red}Failed creating ${CONFIG_DIR}, exiting...${normal}"
		exit 1
	}
	echo "${ylw}Done!${normal}"

	# Refreshing XDG user directories
	echo "${ylw}Creating XDG user directories...${normal}"
	xdg-user-dirs-update || {
		echo "${bold}${red}Failed creating XDG user directories, exiting...${normal}"
		exit 1
	}
	echo "${ylw}Done!${normal}"
}

# Removing .git directory so it won't get copied unnecessary
function remove_git_directory() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Removing .git directory...${normal}"
		rm -rf .git || {
			echo "${bold}${red}Failed removing .git directory, exiting...${normal}"
			exit 1
		}
		echo "${ylw}Done!${normal}"
	else
		echo "${bold}${red}Make sure you cloned (https://github.com/3rfaan/dotfiles.git) into your ~/Downloads folder!${normal}"
		exit 1
	fi
}

# Copying dotfiles from Downloads folder to ~/.config
function copy_config_files() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Copying files from ${DOWNLOAD_DIR} to ${CONFIG_DIR}...${normal}"
		cp -Rfv "$DOWNLOAD_DIR/dotfiles/." "$CONFIG_DIR" || {
			echo "${bold}${red}Failed copying files from ${DOWNLOAD_DIR} to ${CONFIG_DIR}, exiting...${normal}"
			exit 1
		}
		echo "${ylw}Done!${normal}"
	else
		echo "${bold}${red}Make sure you cloned (https://github.com/3rfaan/dotfiles.git) into your ~/Downloads folder!${normal}"
		exit 1
	fi
}

# Copying files which target destinations are not in ~/.config
function copy_others() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Copying files to other directories${normal}"

		# If user provided command line argument ("utm" or "vbox") then copy X11 files to xorg.conf.d else don't copy anything to xorg.conf.d
		if [ "$system" == "utm" ]; then
			sudo cp -Rfv "$DOWNLOAD_DIR/dotfiles/Xorg/UTM/." "/etc/X11/xorg.conf.d"
		elif [ "$system" == "vbox" ]; then
			sudo cp -Rfv "$DOWNLOAD_DIR/dotfiles/Xorg/VBox/." "/etc/X11/xorg.conf.d"
		fi

        # If no argument was provided delete Xorg folder from ~/.config
        if [ -z "$system" ] && [ -d "$CONFIG_DIR/Xorg" ]; then
            sudo rm -Rfv "$CONFIG_DIR/Xorg"
        fi

		if [[ ! -d "$HOME/.local/share/rofi" ]]; then
			mkdir -p "$HOME/.local/share/rofi/themes"
			cp -Rfv "$DOWNLOAD_DIR/dotfiles/rofi/squared-everforest.rasi" "$HOME/.local/share/rofi/themes/squared-everforest.rasi"
		fi

		cp -Rfv "$DOWNLOAD_DIR/dotfiles/Xorg/.xinitrc" "$HOME/.xinitrc"
		cp -Rfv "$DOWNLOAD_DIR/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
		echo "${ylw}Done!${normal}"
	else
		echo "${bold}${red}Make sure you cloned (https://github.com/3rfaan/dotfiles.git) into your ~/Downloads folder!${normal}"
		exit 1
	fi
}

# Copying wallpaper to Downloads folder
function set_wallpaper() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Setting wallpaper${normal}"
		cp -Rfv "$DOWNLOAD_DIR/dotfiles/flowers.png" "$DOWNLOAD_DIR/flowers.png"
		echo "${ylw}Done!${normal}"

		# Changing directory to ~/.config
		cd "$CONFIG_DIR" || exit 1
		echo "${ylw}Changed directory to $(pwd)${normal}"

		echo "${ylw}Removing some unnecessary files...${normal}"
		rm -rfv asus Xorg urxvt lf i3/i3status screenshot-20221230-145517Z-all.png nvim/init.vim nvim/coc-settings.json install.sh zsh || {
			echo "${bold}${red}Failed removing directories not needed for the configuration, exiting..."
			exit 1
		}
		echo "${ylw}Done!${normal}"
	else
		echo "${bold}${red}Make sure you cloned (https://github.com/3rfaan/dotfiles.git) into your ~/Downloads folder!${normal}"
		exit 1
	fi
}

function install_shell_tools() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Installing shell tools${normal}"

		# Packer
		if [[ ! -d $HOME/.local/share/nvim/site/pack/packer ]]; then
			git clone --depth 1 https://github.com/wbthomason/packer.nvim "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
		else
			echo "${grn}Packer is already installed${normal}"
		fi

		# ZSH auto suggestions
		if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]]; then
			git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
		else
			echo "${grn}ZSH auto suggestions is already installed${normal}"
		fi

		# ZSH syntax highlighting
		if [[ ! -d $HOME/.zsh/zsh-syntax-highlighting ]]; then
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
		else
			echo "${grn}ZSH syntax highlighting is already installed${normal}"
		fi

		# Icons for ranger
		if [[ ! -d $CONFIG_DIR/ranger/plugins/ranger_devicons ]]; then
			git clone https://github.com/alexanderjeurissen/ranger_devicons "$CONFIG_DIR/ranger/plugins/ranger_devicons"
		else
			echo "${grn}Ranger devicons is already installed${normal}"
		fi
	else
		echo "${bold}${red}Make sure you cloned (https://github.com/3rfaan/dotfiles.git) into your ~/Downloads folder!${normal}"
		exit 1
	fi
}

# Removing install files after moving them to .config
function remove_install_file() {
	if [[ -d $DOWNLOAD_DIR/dotfiles ]]; then
		echo "${ylw}Removing installation files...${normal}"
		rm -rf "$DOWNLOAD_DIR/dotfiles"
		echo "${ylw}Done removing installation files${normal}"
	fi
}

main "$@"
exit
