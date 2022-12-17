# 
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║     
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║     
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
# ZSH Config File by Arfan Zubi
                                        

# Autostart X at Login
if [ -z "${DISPLAY}"  ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

# Aliases
alias q='exit'
alias ..='cd ..'
alias ls='lsd -Fl'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias t='tree'
alias rm='rm -v'
alias open='xdg-open'

alias vi='nvim'
alias vim='nvim'

alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Colored Output
#alias ls='ls -laGH --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'

export LESS='-R --use-color -Dd+r$Du+b'
export MANPAGER='less -R --use-color -Dd+r -Du+b'
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Setting Default Editor
export EDITOR='nvim'

# ZSH Case-Insensitive Autocomplete
autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
compinit
_comp_options+=(globdots)

# Load Additional Glyphs for Fira Code Font
source ~/.local/share/icons-in-terminal/icons_bash.sh

# Load Version Control System into Prompt
autoload -Uz vcs_info
precmd() { vcs_info }

# Set up Git Branch Details into Prompt
zstyle ':vcs_info:git:*' formats 'on %F{red} %b%f '

# Prompt Appearance
setopt PROMPT_SUBST
PROMPT='%B%F{cyan}[%n%f@%F{cyan}%m]%f %F{blue} %1~%f%b ${vcs_info_msg_0_}>===> '

# Setting default Ranger RC to false to avoid loading it twice
export RANGER_LOAD_DEFAULT_RC='false'

# Theme for bat (batcat)
export BAT_THEME='base16'

# Icons for lf file manager
#[ -f ~/.config/LF_ICONS ] && {
#	LF_ICONS="$(tr '\n' ':' <~/.config/LF_ICONS)" \
#		&& export LF_ICONS
#}

# Keybindings for FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ZSH Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# VIM Keybindings for ZSH
#source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ZSH Syntax Highlighting - must be at the end of .zshrc!
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
