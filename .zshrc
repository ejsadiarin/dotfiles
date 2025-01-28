##############################
#         Variables          #
##############################

# TODO: migrate to wezterm
if [ ! -f /usr/bin/kitty ]; then
    export TERM=xterm-256color
    export TERMINAL=xterm-256color
else
    export TERM=kitty
    export TERMINAL=kitty
fi

export VISUAL="nvim"
export BROWSER='firefox'
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)
export EDITOR='nvim'
export SHELL="/usr/bin/zsh"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export VAULT="$HOME/vault"
# export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/title/XDG_Base_Directory#Support
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# NOTE this is handled by sdm/sddm/gdm (session managers, IF SYSTEM is using systemd)
# if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
#   echo "\$XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) not writable. Unsetting." >&2
#   unset XDG_RUNTIME_DIR
# else
#   export XDG_RUNTIME_DIR
# fi

# scripts-magic-spells
mkdir -p "$HOME/.local/bin"
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
    PATH="$VAULT/wizardry/scripts-magic-spells:$PATH"
fi

# go
if [ -f "/usr/bin/go" ]; then
    export PATH="$PATH:/usr/local/go/bin"
    export PATH="$PATH:$HOME/go/bin"
fi

# restic
if [ -f "$HOME/services/restic/restic-env" ]; then
    source "$HOME/services/restic/restic-env"
fi

# dotnet
if [ -f "/usr/bin/dotnet" ]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi

# nvm
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"               # This loads nvm bash_completion
    alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@" # fix perf issue
fi

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi

# flyctl
if [ -d "$HOME/.fly" ]; then
    export FLYCTL_INSTALL="$HOME/.fly"
    export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi

##############################
#          Plugins           #
##############################

# initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

##############################
#        Keybindings         #
##############################
# --> note that ^ means ctrl
# --> do "zle -al | fzf" to see all bindkey actions

# enable vim-like keybindings (insert mode by default, do esc for normal)
bindkey -e

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^b' backward-word
bindkey '^f' forward-word
bindkey '^l' forward-char
bindkey '^h' backward-char
# bindkey '^f' forward-word
# bindkey '^r' reverse-search-history # overidden by zsh-fzf-history-search
bindkey '^w' backward-kill-word

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Enable Ctrl + Left Arrow to move one word left
bindkey '^[[1;5D' backward-word

# Enable Ctrl + Right Arrow to move one word right
bindkey '^[[1;5C' forward-word

##############################
#          Autoload          #
##############################
autoload -Uz compinit && compinit -C
# autoload -Uz compinit

# for dump in ~/.config/zsh/zcompdump(N.mh+24); do
#   compinit -d ~/.config/zsh/zcompdump
# done
#
# compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

##############################
#           Styles           #
##############################
zstyle ':completion:*' verbose true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#
zstyle ':completion:*' menu no
# zstyle ':completion:*:*:*:*:*' menu select
#
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B[%F{blue}%f %F{yellow}%b%f]'

##############################
#          History           #
##############################
mkdir -p "$XDG_CONFIG_HOME/zsh"
HISTFILE=~/.config/zsh/zhistory
# HISTFILE=~/.zsh_history
HISTSIZE=25000
SAVEHIST=25000

setopt autocd                  # change directory just by typing its name
setopt prompt_subst            # enable command substitution in prompt
setopt menu_complete           # Automatically highlight first element of completion menu
setopt list_packed		         # The completion menu takes less space.
setopt auto_list               # Automatically list choices on ambiguous completion.
setopt hist_ignore_space       # When searching history don't display results already cycled through twice
setopt hist_ignore_dups	       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_all_dups	   # Do not write events to history that are duplicates of previous events
setopt hist_find_no_dups       # When searching history don't display results already cycled through twice
setopt complete_in_word        # Complete from both ends of a word.
setopt appendhistory           # Append commands to history file rather than overwriting it
setopt sharehistory            # Share history of commands across all sessions

##############################
#           Prompt           #
##############################
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        echo "%B%F{red} %f%b"
    else
        echo "%B%F{red} %f%b"
    fi
}

SSH_TTY=$(env | grep SSH_TTY)
if [ -n "$SSH_TTY" ]; then
    echo "[LOG: is on SSH_TTY...]"
    PS1='%B%F{#fcffb8}:%f%b%B%F{green}$(whoami)@$(hostname) %f%b%B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{#a2e57b}.%F{red})\$ %f%b'
else
    # PS1='%B%F{#fcffb8} %f%b $(dir_icon) %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{#a2e57b}⮞⮞.%F{red}⮞⮞)  %f%b'
    # PS1='%B%F{blue} %f%b %B%F{white} %f%b %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '
    PS1='%B%F{#fcffb8}: %f%b%B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{#a2e57b}.%F{red})\$ %f%b'
    # PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '
fi

##############################
#           Title            #
##############################
function xterm_title_precmd () {
    print -Pn -- '\e]2;%n@%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi


##############################
#          Aliases           #
##############################

if [ -f "/usr/bin/bat" ]; then
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

alias f='fzf -m --preview="bat --color=always {}" --bind="enter:become(nvim {})"'
alias k='kubectl'

if [ -f /etc/arch-release ]; then
    alias ,pac_mirrors="sudo reflector --verbose --latest 5 --country 'Singapore' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
    alias ,pac_grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
    alias ,pac_maintenance="yay -Sc && sudo pacman -Scc"
    alias ,pac_purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
    alias ,pac_update="paru"
    # alias ,pac_update="paru -Syu --nocombinedupgrade"
fi

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias music="ncmpcpp"

if [ -f "/usr/bin/lsd" ]; then
    alias ls='lsd -a --group-directories-first'
    alias ll='lsd -la --group-directories-first'
else
    alias ls='ls -a --color=auto'
    alias ll='ls -la --color=auto'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ..='cd ..'

alias neofetch="clear && neofetch"
alias ne="clear && neofetch"
alias re="OpenApps --rxfetch"
alias timezsh="time zsh -i -c exit"

alias history="history 1"

# scripts-magic-spells aliases
if [ -d "$HOME/vault/wizardry/scripts-magic-spells/" ]; then
    alias ,t=",todo"
    alias ,b=",backlog"
fi

alias ,mostusedcommands="history | awk '{print \$2}' | sort | uniq -c | sort -nr | head -10"
alias ,datezet="date +%Y%m%d"
alias ,ipshow="ip link | awk '/state UP/ {print \$2}' | tr -d :"

if [[ -f "/usr/bin/lazygit" || -f "/bin/lazygit" || -f "$HOME/go/bin/lazygit" ]]; then
    alias lg="lazygit"
fi

if [[ -f "/usr/bin/lazydocker" || -f "/bin/lazydocker" || -f "$HOME/go/bin/lazydocker" ]]; then
    alias lzd="lazydocker"
fi

alias clpwd="pwd | xclip -selection clipboard"
alias copy="xclip -sel clip"

if [ -f "/usr/bin/nvim" ] || [ -f "/bin/nvim" ]; then
    alias snvim="sudo -E nvim $1"
    if [ -d "$XDG_CONFIG_HOME/nvim-old" ]; then
        alias nvim-old='NVIM_APPNAME="nvim-old" nvim'
    fi
    if [ -d "$XDG_CONFIG_HOME/lvim" ]; then
        alias lvim='NVIM_APPNAME="lvim" nvim'
    fi
fi

##############################
#            Eval            #
##############################
#  comment this out if not want ascii art every terminal open
# $HOME/.local/bin/colorscript -r
# eval "$(thefuck --alias)"

# ctrl+r for fzf reverse search
if [ -f "/usr/bin/fzf" ]; then
    if [ "$SHELL" = "/usr/bin/zsh" ] || [ "$SHELL" = "/bin/zsh" ]; then
        eval $(fzf --zsh)
    elif [ "$SHELL" = "/usr/bin/bash" ] || [ "$SHELL" = "/bin/bash" ]; then
        eval $(fzf --bash)
        # command -v eval $(fzf --bash) >/dev/null 2>&1
    fi
fi

if [ -f "/usr/bin/fuck" ]; then
    eval $(thefuck --alias)
fi

if [ -f "/usr/bin/zoxide" ]; then
    eval $(zoxide init --cmd cd zsh)
fi

##############################
#         API KEYS           #
##############################
current_dir=$(basename "$(pwd)")
if [[ $current_dir == "nvim" ]] then
    export OPENAI_API_KEY=$(pass show keys/openai | head -n 1)
    export DEEPSEEK_API_KEY=$(pass show keys/deepseek | head -n 1)
    export ANTHROPIC_API_KEY=$(pass show keys/anthropic | head -n 1)
fi

# if on MacOS uncomment: for homebrew installed apps available on PATH 
# eval "$(/opt/homebrew/bin/brew shellenv)" 

##############################
#        Useful Things       #
##############################
# useful commands
# time the zsh startup: 
# time zsh -i -c exit (or use /usr/bin/time instead of time, if time not available)

# xprop | grep WM_CLASS
# xinput => to see devices connected
# xinput set-prop "<device name here>" "libinput Natural Scrolling Enabled" 1
# xinput list-props "<device name here>" => to see all properties of device

# https://stackoverflow.com/questions/11124053/accidentally-committed-idea-directory-files-into-git
# - this just removes .idea directory from git tracking (staging)
# git rm -r --cached .idea

# Bluetoothctl => connect and pair via bluetooth (tab completion is available for MAC_addresses)
# ref: https://wiki.archlinux.org/title/bluetooth
#
# check if bluetooth is on
# systemctl status bluetooth.service
# systemctl start bluetooth.service --> start bluetooth 
#  - can use "enable" but not ideal since bluetooth will turn on when startup
#
# bluetoothctl --> enter bluetooth shell
# devices --> see devices (if no showing, do a "scan on" first)
# scan on --> scan devices with bluetooth turned on
# agent on --> default-agent should be appropriate on most cases
# pair <MAC_address> --> pair device via bluetooth, use tab for completion
#   - trust <MAC_address> --> if using devices without a PIN, need to manually trust it before it can reconnect
#   successfully
#   - connect <MAC_address> --> establish a connection
#   Sesh Evo: 60:C5:E6:9F:0D:E9
#   Just `connect 60:C5:E6:9F:0D:E9

# [ Adding submodules to a git repo: ]
# git submodule add <url> <path>
# -- TO UPDATE SUBMODULES (when the linked repo updated, ex. new nvim configs):
# git submodule update --recursive --remote

# [ Copy contents of output (works in X11 only with xclip)]
# <command> | xclip -selection clipboard 
# or <command> | xclip -sel clip 
# ex. pwd | xclip -selection clipboard
# UPDATE (December 24, 2023 3:32 AM): made an alias for this, clpwd
# best when using with lg (my lazygit alias)
#
# Warpinator (ftp in LAN)
# - updating firewalld rules via firewall-config (GUI) or firewall-cmd
# - also changing the default ports
# https://forum.endeavouros.com/t/firewalld-setting-to-connect-via-warpinator/26323
# - remember to uncheck zones after using warpinator
#
# Firewalld [ UPDATE: just use ufw and save the hassle ] 
# - see fedora docs: https://docs.fedoraproject.org/en-US/quick-docs/firewalld/
# - useful to install the GUI version also
#
# ufw
# - ufw allow 22/tcp 22/udp 80/tcp 80/udp 443/tcp 443/udp
