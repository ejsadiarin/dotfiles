# Exquisite Nvim Config
1. Ensure to install the following dependencies using your package manager:
- git
- gcc
- make
- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- [fd](https://github.com/sharkdp/fd#installation)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- [lazygit](https://github.com/jesseduffield/lazygit)

2. Install the config
- backup your existing config:
  ```bash
  # required
  mv ~/.config/nvim{,.bak}
  # optional but recommended
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}
  ```

- clone Exquisite Config:
  ```bash
  git clone https://github.com/ejsadiarin/best-neovim-config.git ~/.config/nvim
  # Remove the git folder so you can add to your own repo
  rm -rf ~/.config/nvim/.git
  ```

- start nvim to install plugins:
  ```bash
  nvim
  ```

# Workflow
### NOTE:
- root/dynamic - telescope searches via git root based on current active buffer (respects `.gitignore`)
- cwd - where you opened `nvim` command (after `cd`-ing to dirs)

## Main commands:
- `<leader>ff` - find files (root/dynamic)
- `<leader>fH` - find files from home
- `<leader>fp` - find projects (useful for changing cwd)
- `<leader>fr` - find recent files
- `<leader>fS` - file system (cwd)
- `<leader>fs` - file system (root/dynamic)
- `<leader>xx` - diagnostics (current buffer)
- `<leader>xX` - diagnostics (workspace)
### Harpoon
- `<leader>fh` - find harpoon marks (workspace)
- `<leader>ha` - add harpoon marks (workspace)
- `<C-n> and <C-p>` - cycle through harpoon marks (workspace)
### Grepping
- `<leader>sg` - live grep with args (root/dynamic)
  - combo: `<leader>sg` search: "<prompt>" <path>/<to>/<search>
- `<leader>sG` - live grep with args from home
- `<leader><space>` - manual grep via command, output through quickfix list (<leader>xq):
  - ex. `:silent grep Foo src/components/`
  - `<leader>xq` - quickfix list (for grep output)
### Git
- `<leader>gg` - open lazygit (root/dynamic)
- `<leader>gs` - git status (root/dynamic)
---
### Powered by 💤 LazyVim
  - A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
  - Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
