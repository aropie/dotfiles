EDITOR="emacsclient -c -n"
BROWSER="vivaldi-stable"
TERMINAL="terminator"
export LPASS_USERNAME="aropie@hotmail.com"

export TERM="xterm-256color"
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$GOPATH/bin

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

# Prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs newline virtualenv_joined context_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time)

# Prompt settings
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

# Context
DEFAULT_USER=$USER
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_TEMPLATE=" %F{088}\uf1d0"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='241'

# Dirs
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION=""

# OS segment
POWERLEVEL9K_OS_ICON_BACKGROUND='black'
POWERLEVEL9K_LINUX_ARCH_ICON='%F{cyan}'

# Virtualenv
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

# VCS
POWERLEVEL9K_VCS_GIT_ICON=$''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$''
POWERLEVEL9K_VCS_SHORTEN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=".."

# Battery
POWERLEVEL9K_BATTERY_LOW_FOREGROUND='red'
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='yellow'
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='green'
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='blue'

# Status
POWERLEVEL9K_STATUS_CROSS=true

# Time
POWERLEVEL9K_TIME_FORMAT="%F{black}\uf017 %D{%I:%M}%f"

# Adding interative prompt
autoload -Uz promptinit
promptinit

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git sudo zsh-syntax-highlighting docker)

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

export MPD_HOST="localhost"
export MPD_PORT="6601"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /usr/share/nvm/init-nvm.sh
