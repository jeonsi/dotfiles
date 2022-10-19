# 
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║     
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║     
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
# ZSH Config File by Arfan Zubi
                                        

#  Aliases
alias rm='rm -v'
alias ls='ls -laGH --color=auto'
alias vi='nvim'
alias vim='nvim'

# Autostart X at Login
if [ -z "${DISPLAY}"  ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

# ZSH Case-Insensitive Autocomplete
autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
compinit
_comp_options+=(globdots)

# Load Version Control System into Prompt
autoload -Uz vcs_info
precmd() { vcs_info }

# Set up Git Branch Details into Prompt
zstyle ':vcs_info:git:*' formats '%b '

# Prompt Appearance
setopt PROMPT_SUBST
PROMPT='%B%F{cyan}[%n%f@%F{cyan}%m]%f %F{blue}%1~%f%b | %Bλ%b '

# Theme for bat (batcat)
export BAT_THEME="base16"

# Keybindings for FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ZSH Autosuggestions
source ~/Sources/zsh-autosuggestions/zsh-autosuggestions.zsh

# VIM Keybindings for ZSH
#source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ZSH Syntax Highlighting - must be at the end of .zshrc!
source ~/Sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

