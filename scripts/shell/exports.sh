# exports, loaded by .zshrc

export PATH="$PATH:/home/xzvf/.local/install/npm-global/bin:/bin:/home/xzvf/.local/bin:/home/xzvf/.gem/ruby/2.6.0/bin:/home/xzvf/inst/android-sdk/platform-tools/:/home/xzvf/.local/bin/flutter/bin:/home/xzvf/.gem/ruby/2.7.0/bin:/home/xzvf/.cargo/bin:/var/lib/snapd/snap/bin:/opt/sublime_text/:/opt/sublime_merge/:/opt:/home/xzvf/.emacs.d/"
export ANDROID_HOME="$HOME/inst/android-sdk"
export BROWSER="/usr/bin/firefox"
export EDITOR='nvim'
export VISUAL='nvim'
#export MOZ_X11_EGL=1

load-nvm(){
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
