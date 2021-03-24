# Start xorg on login
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  exec startx
fi

export KEEP_ZSHRC=yes
# Check for oh-my-zsh and if its missing, download it
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
export ZSH=~/.oh-my-zsh

if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
   git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZSH_THEME="powerlevel10k/powerlevel10k"

# Adding interative prompt
autoload -Uz promptinit
promptinit

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git sudo zsh-syntax-highlighting docker docker-compose)

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

# This is to be able to work with modern terminal emulators
# through ssh
alias ssh="TERM=xterm-256color ssh"

alias icat="kitty +kitten icat"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Copying locally huge files
# -a is for archive, which preserves ownership, permissions etc.
# -v is for verbose, so I can see what's happening (optional)
# -h is for human-readable, so the transfer rate and file sizes are easier to read (optional)
# -W is for copying whole files only, without delta-xfer algorithm which should reduce CPU load
# --no-compress as there's no lack of bandwidth between local devices
# --progress so I can see the progress of large files (optional)

# Usage: supercp /src /dst
alias supercp="rsync -avhW --no-compress --progress"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/home/rodriguezpie/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# g4d completion
if [[ -f /etc/bash_completion.d/g4d ]]; then
  . /etc/bash_completion.d/p4
  . /etc/bash_completion.d/g4d
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Golang
export GOPATH=~/.gocode
export PATH=$PATH:$GOPATH/bin