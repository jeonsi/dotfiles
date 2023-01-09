#!/usr/bin/env bash

if [[ ! -d $HOME/.config ]]; then
	mkdir -p "$HOME/.config"; else
    rm -rf "$HOME/.config"
fi

git clone https://github.com/3rfaan/dotfiles.git "$HOME/.config"

cd "$HOME/.config" || exit
rm -rf asus Xorg urxvt i3/i3status README.md screenshot-20221230-145517Z-all.png nvim/init.vim nvim/coc-settings.json
