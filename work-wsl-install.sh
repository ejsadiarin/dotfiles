#!/bin/bash

# NOTE: zsh, tmux, neovim, opencode

# install essentials
echo "[INSTALL] Installing essential binaries"
sudo apt install -y zsh vim tmux gpg gcc make git ripgrep fd-find unzip fzf openssh-server curl

# NOTE: runtimes (node, bun, etc.)
# instal nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
nvm install 24

# symlink home configs
echo "[WARN] Removing home configs"
rm -f ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/
rm -f ~/.vimrc
ln -s ~/dotfiles/.vimrc ~/

# rm -f ~/.gitconfig
# ln -s ~/dotfiles/.gitconfig ~/

# NOTE: tmux
echo "[WARN] Removing tmux configs: ~/.config/tmux"
rm -rf ~/.config/tmux
rm -f ~/.tmux.conf
ln -s ~/dotfiles/tmux ~/.config/tmux
ln -s ~/dotfiles/tmux/.tmux.conf ~/
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source ~/.tmux.conf
echo "[INFO] open tmux then do <ctrl+b> + I"

# NOTE: neovim
echo "[Install] neovim config"
rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
# install rust and cargo for tree-sitter-cli
curl https://sh.rustup.rs -sSf | sh
cargo install --locked tree-sitter-cli
echo "[INFO] open nvim and let it lazy install"

# NOTE: opencode
sudo npm i -g bun
bun add -g opencode-ai
echo "[WARN] Removing opencode configs at ~/.config/opencode"
rm -f ~/.config/opencode/opencode.json
ln -s ~/dotfiles/config/opencode/opencode.jsonc ~/.config/opencode/
ln -s ~/dotfiles/config/opencode/tui.json ~/.config/opencode/
ln -s ~/dotfiles/config/opencode/AGENTS.md ~/.config/opencode/

# NOTE: fonts
# - INSTALL zip => extract => search "Regular" => Install (or Show more options => Install to all users)
echo "[INSTALL] Downloading IosevkaTerm Nerd Font"
# mkdir -p ~/.local/share/fonts/IosevkaTerm
# curl -Lo /tmp/IosevkaTerm.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.tar.xz
# tar -xf /tmp/IosevkaTerm.tar.xz -C ~/.local/share/fonts/IosevkaTerm
# fc-cache -fv ~/.local/share/fonts/IosevkaTerm
echo "[Windows WSL2 detected] INSTALL zip => extract => search 'Regular' => Install (or Show more options => Install to all users)"
