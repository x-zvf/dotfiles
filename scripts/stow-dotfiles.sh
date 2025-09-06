#!/usr/bin/env bash
cd "$(dirname "$0")/../home"
stow . -t ~ --dotfiles
