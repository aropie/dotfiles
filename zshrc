# Start xorg on login
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  exec startx
fi

# Check for oh-my-zsh and if its missing, download it
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
export ZSH=~/.oh-my-zsh

if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
   git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi


ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Prompt settings
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Prompt elements
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs newline virtualenv_joined context_joined)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon virtualenv dir dir_writable vcs newline context)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time)

# Prompt settings
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

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
alias dclogs="sudo docker-compose logs"
alias dcpull="sudo docker-compose pull"

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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# g4d completion
if [[ -f /etc/bash_completion.d/g4d ]]; then
  . /etc/bash_completion.d/p4
  . /etc/bash_completion.d/g4d
fi
