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

## Philosophy
- My keybindings are based on this mental model grammar:
`<leader>` + `<verb>` + `<noun>`
- "nouns":
  - `f` - files
  - `m` - main (`~/main`)
  - `c` - nvim configs
  - `d` - dotfiles
  - `h` - harpoon
  - `H` - home
  - `p` - projects
  - `x` - diagnostics
  - `g` - git

## Main commands (`<leader>` + `<verb>` + `<noun>`):
- `<leader>ff` - (f)ind (f)iles (root/dynamic)
- `<leader>fg` - (f)ind (g)it root (root/dynamic)
- `<leader>fm` - (f)ind files from (m)ain (`main` - directory where I store projects)
- `<leader>fd` - (f)ind files from (d)otfiles
- `<leader>fc` - (f)ind files from .(c)onfig
- `<leader>fH` - (f)ind files from (H)ome
- `<leader>fp` - (f)ind projects (useful for changing cwd)
- `<leader>fr` - (f)ind recent files
- `<leader>cw` - (c)hange (w)orking directory (based on head of current buffer: `:cd %:h`)
- `<leader>cd` - (c)ode diagnostics (current line)
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

## Hacks (my favorite workflow):
### Project-scoped
- use `<leader>ff` (find files) and `<leader>sg` (grep) for everything project/repository-scoped - best keymaps
- use `<leader>fg` (find git root)
  - useful for finding the parent root of a repo
- use `<C-/>` to open terminal (cwd)
- use `<leader>gg` for lazygit (recommended)
- use visual multi-select:  
  - `<leader>vm` then `\\A` for start and select all similar words under the cursor - like `<C-S-l>` in vscode
    - doing this automatically puts you in "expand mode" (like visual mode)
    - <tab> to change mode to "cursor mode"
  - `<leader>vm` then `\\@` for start and apply macro
    - can also do native Visual Block: `<C-v` then apply macro
  - `<M-C-k>` to select up and `<M-C-j>` to select down (start and select simultaneously)
- use Harpoon:
  - `<leader>fh` and `<leader>ha` for finding and adding harpoon marks, respectively
  - `<C-n>` and `<C-p>` for cycling next and previous harpoon marks
- for debugging and testing:
  - `<leader>cd` for code diagnostics (current line)
  - `<leader>du` open DAP UI
  - `<leader>t+` for running tests (the `+` indicates that there are more options available)

### Going outside the project
- use `<leader>fm` (files) for searching a project/repository (in `~/main`)
  - have a `~/main` directory if you want this to work (recommended)
- use `<leader>fc` for finding `.config` files
- use `<leader>fd` for finding dotfiles from `~/dotfiles`
  - combo: `<leader>fd` then type `nvim/` or `tmux/` for the nvim and tmux configs, respectively
  - use `<leader>cw` to manually change cwd if needed (useful for opening a new terminal, changing project, etc.)
  - NOTE: `cwd` or current working directory automatically changes on buffer navigation, its just that some projects don't if there is no `.git` directory or no `.gitignore`

- other useful:
  - `<leader>fr` - find recent files
  - `<leader>fp` - find projects
  - `<leader>xx` - project diagnostics
  - `<leader>xX` - project diagnostics


---
### Powered by 💤 LazyVim
  - A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
  - Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
