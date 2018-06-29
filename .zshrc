EDITOR="emacsclient -c -n"
BROWSER="vivaldi-stable"
TERMINAL="terminator"

export TERM="xterm-256color"
export PATH=$PATH:$HOME/.scripts

# Start xorg on login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Check for oh-my-zsh and if its missing, download it
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
export ZSH=~/.oh-my-zsh

if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Prompt settings
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Context
DEFAULT_USER=$USER
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_TEMPLATE="%F{088}\uf1d0"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='241'

# Dirs
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

# OS segment
POWERLEVEL9K_OS_ICON_BACKGROUND='black'
POWERLEVEL9K_LINUX_ICON='%F{cyan}\uf300 %F{white}arch%F{cyan}linux%f'

# Virtualenv
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

# Ram
POWERLEVEL9K_RAM_ELEMENTS=ram_free

# VCS
POWERLEVEL9K_VCS_GIT_ICON=$''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$''

# Battery
POWERLEVEL9K_BATTERY_LOW_FOREGROUND='red'
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='yellow'
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='green'
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='blue'

# Status
POWERLEVEL9K_STATUS_CROSS=true

# Time
POWERLEVEL9K_TIME_FORMAT="%F{black}\uf017 %D{%I:%M}%f"

# Prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs newline virtualenv rbenv context)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time time)

# Adding interative prompt
autoload -Uz promptinit
promptinit

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git sudo z django zsh-syntax-highlighting docker)

source $ZSH/oh-my-zsh.sh

# Virtualenv wrapper
source /usr/bin/virtualenvwrapper.sh

# Ruby
# PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"

# Aliases
alias music="ncmpcpp"
alias p="sudo pacman"
alias h="htop"
alias starwars="telnet towel.blinkenlights.nl"
alias dcrun="sudo docker-compose run --rm"
alias dcup="sudo docker-compose up"
alias dcdown="sudo docker-compose down"
alias dcbuild="sudo docker-compose build"

# Music
alias pause="mpc toggle"
alias next="mpc next"
alias prev="mpc prev"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

