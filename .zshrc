# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# .zshrc - configuration file loaded by zsh.


source ~/scripts/shell/exports.sh
source ~/scripts/shell/aliases.sh
source ~/scripts/shell/functions.sh
source ~/scripts/shell/ssh_stuff.sh
source ~/scripts/shell/private_stuff.sh

# Oh my zsh stuff:
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
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

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey -v
cd ~

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
