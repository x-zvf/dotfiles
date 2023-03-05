if [ "$(uname -a | grep -Eoh 'WSL2')" != "" ]; then
   cd ~
    RUNNING=`ps aux | grep dockerd | grep -v grep`
    if [ -z "$RUNNING" ]; then
        sudo dockerd > /dev/null 2>&1 &
        disown
        echo WSL: started dockerd
    fi
    RUNNING=`ps aux | grep crond | grep -v grep`
    if [ -z "$RUNNING" ]; then
        sudo crond
        echo WSL: started crond
    fi
fi;


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# .zshrc - configuration file loaded by zsh.

source ~/scripts/shell/exports.sh
source ~/scripts/shell/aliases.sh
source ~/scripts/shell/functions.sh
source ~/scripts/shell/ssh_stuff.sh
source ~/scripts/shell/private_stuff.sh

# Oh my zsh stuff:
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
   git
   pass
#  zsh-autosuggestions
#  zsh-syntax-highlighting
)

#fastfetch
source $ZSH/oh-my-zsh.sh

bindkey -v

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

