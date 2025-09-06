#!/usr/bin/env bash

sudo pacman -S base-devel git nvim zsh curl wget gdb rsync flatpak stow
cd /usr/local/src
sudo chown -R root:wheel .
sudo chmod 775 .
mkdir aur
cd aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S \
    plasma-meta kde-applications-meta sddm sddm-kcm \
    wl-clipboard \
    firefox ungoogled-chromium-bin \
    bitwarden homebank nextcloud-client signal-desktop ferdium-bin \
    libreoffice onlyoffice-bin xournalpp \
    qpwgraph easyeffects  \
    qalculate-qt \
    vlc mpv gimp krita audacity inkscape yt-dlp spotify \
    ghostty tmux \
    fastfetch htop btop iotop glances amdgpu_top \
    perf bpftrace hyperfine \
    unzip p7zip zip \
    nfs-utils \
    fw-ectool-git \
    cht.sh-git \
    dig mtr  \
    bat fd file ripgrep ripgrep-all lsd fzf \
    httpie htmlq jq yq \
    sequoia \
    sshfs \
    traceroute tree binwalk \
    xxd hexdump \
    insomnia \
    sublime-merge sublime-text-4 emacs code \
    ghidra \
    clang cmake \
    clojure clojure-lsp leiningen babashka \
    ghc swi-prolog zig rustup \
    go gopls \
    nixfmt shellcheck \
    hugo \
    sqlite postgresql-libs \
    nodejs npm nodejs-live-server \
    python-pandas python-numpy python-matplotlib jupyterlab jupyter-notebook python-black python-isort pyright python-flake8 pyright \
    lua-language-server stylua \
    texlive texlive-langgerman biber \
    typst tinymist \
    python-pympress \
    pandoc \
    cloc \
    hcloud \
    git-delta \
    github-cli glab \
    libtool \
    platformio-core platformio-core-udev avrdude \
    mathematica \
    blender hip-runtime-amd \
    nautilus \
    pferd \
    timewarrior \
    ttf-firacode-nerd \
    tmux-plugin-manager \
    tree-sitter-cli \
    distrobox \
    locate

flatpak install flathub io.github.ungoogled_software.ungoogled_chromium
flatpak install flathub com.behringer.XAirEdit

sudo systemctl enable --now sddm.service
