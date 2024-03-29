# aliases sourced by .zshrc

# git
alias gu="git add -u; git commit -m "
alias gpsh="git push"
alias gpll="git pull"
alias gcln="git clone"
alias gstat="git status"
alias gstapush="git stash push"
alias gstapop="git stash pop"
alias gcom="git commit"
alias gdiff="git diff"
alias ga="git add"

alias ogh="$BROWSER https://github.com/x-zvf"

#The. Best. Way. To. Commit.
alias gy='git commit -am "`curl -s http://whatthecommit.com/index.txt`"'

# Youtube dl
alias yt-dl-mp3="yt-dlp -x --audio-format mp3 --audio-quality 0 -i --add-metadata --metadata-from-title"


# Wifi
alias wlan-up="sudo ip link set wlo1 up"
alias wlan-down="sudo ip link set wlo1 down"

# Make
alias make="/usr/bin/make -j$(nproc)"
export MAKEFLAGS="-j$(nproc)"

#wsl
alias exp="explorer.exe ."

# Random
#alias fucking="sudo !!"
#eval $(thefuck --alias)

# Simple QOL improvements
alias t=tmuxinator
alias v=nvim
alias sv="sudo -e"

#alacritty causes problems
alias ssh='TERM=xterm-256color ssh'

alias music='systemctl start mpd --user;ncmpcpp'

alias mntshared="[[ -z $(mount | grep /shared) ]] && sudo mount -t ntfs-3g -o umask=022,gid=998,uid=1000 /dev/sda5 /shared"

# Better standart unix tools
alias l="lsd -lah"
alias b="bat"

alias o="xdg-open"

alias tg="topgrade"

# Fix crappy software
alias unfuckadb="sudo adb kill-server; sudo adb start-server; adb devices"

alias startkdewayland="XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland"
alias findssh="sudo nmap -sS -p 22"

alias xur="reboot"
alias fm="mbsync -a && notmuch new"

#alias subl="/opt/sublime_text/sublime_text"
#alias smerge="/opt/sublime_merge/sublime_merge"

alias nvmon="watch -n1 nvidia-smi"

alias c="curl"
alias fucking="sudo"

alias mhsp="~/scripts/makehotspot.sh"
alias khsp="~/scripts/killhotspot.sh"

# file copy progress
alias fcp="watch -n1 --color \"du -h --max-depth=3 > /tmp/__fcp_temp; wdiff -n /tmp/__fcp_oldtemp /tmp/__fcp_temp | colordiff | sed -e '/\[-.*-\]/d' -e 's/{\+//g' -e 's/\+}//g'; mv /tmp/__fcp_temp /tmp/__fcp_oldtemp\""

alias gla="glances --enable-plugin sensors"

alias mh="~/scripts/makehotspot.sh"
alias kh="~/scripts/killhotspot.sh"

alias kitvpn="sudo openvpn --config ~/Documents/vpn/kit-split.ovpn"

alias emacs="emacsclient -c -a 'emacs'"

#Apparently `which` is not POSIX and deprecated
alias which="command -v"

alias vnc="x11vnc -auth .Xauthority -forever -loop -noxdamage -repeat -rfbauth /home/xzvf/.x11vnc.pass -rfbport 5900 -shared -ncache_cr" # do not use -ncache 10

