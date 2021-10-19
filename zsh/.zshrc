#! /usr/bin/zsh

# Start xorg on login
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  exec startx
fi

export ZSH=~/.config/oh-my-zsh
export KEEP_ZSHRC=yes
# Check for oh-my-zsh and if its missing, download it
if [[ ! -d ~/.config/oh-my-zsh ]]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ ! -d $ZSH/custom/themes/powerlevel10k ]]; then
   git clone https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
fi

if [[ ! -d $ZSH/custom/plugins/zsh-syntax-highlighting ]]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
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

# starts one or multiple args as programs in background
# Taken from https://blog.sebastian-daschner.com/entries/zsh-aliases
background() {
  for ((i=2;i<=$#;i++)); do
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Import aliases
source $ZDOTDIR/aliases

# Golang
export GOPATH=~/.gocode
export PATH=$PATH:$GOPATH/bin
