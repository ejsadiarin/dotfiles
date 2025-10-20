#!/bin/bash

# Configures minimal setup for Quality of Life improvements for remote VMs/VPS terminals
#
# Configures:
# - Ensure SSH Keys are configured
# - copy .bashrc
# - copy .vimrc
#
remote=$1 # ex. ejs@<ip-address>

# TODO: add flags (-h|--help|without flags)

scp -r $HOME/.ssh/id_ed25519.pub "$remote":~/.ssh

# assume cwd is on dotfiles
scp -r ./.bashrc "$remote":~/
scp -r ./.vimrc "$remote":~/
