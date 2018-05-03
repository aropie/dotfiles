# Path to your oh-my-zsh installation.
  export ZSH=/home/$USER/.oh-my-zsh

# Show OS info when opening a new terminal
neofetch

# Aliases
alias pacman-ghost="~/.pacman.sh"
alias h="htop"

pacman-ghost

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Prompt settings
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Context
DEFAULT_USER=$USER
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_TEMPLATE="%F{088}\uf1d0"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='233'

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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs newline virtualenv context)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time ram time)

# Adding interative prompt
autoload -Uz promptinit
promptinit

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git sudo z zhs django)

source $ZSH/oh-my-zsh.sh

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Virtualenv wrapper
source /usr/bin/virtualenvwrapper.sh

# Android variables
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_SDK_ROOT=/home/aropie/Android/Sdk

# MPD config
export MPD_HOST="localhost"
export MPD_PORT="6601"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/aropie/google-cloud-sdk/path.zsh.inc' ]; then source '/home/aropie/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/aropie/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/aropie/google-cloud-sdk/completion.zsh.inc'; fi
