# Golden Red Rose Configuration

- flexible, heavenly fast, and exquisite. A beautiful crossover of practicality and aesthetics.

- mainly focused on having fast keymaps/keybindings with the least mental overhead possible

- if you like this, you will surely love [Wizardry: The Akashic Records of Technology](https://github.com/ejsadiarin/wizardry)
  - where all my knowledge, philosophy, scripts, magic spells, and configuration are archived.

> [!IMPORTANT]
> **The previous BSPWM configs has been moved into a separate branch `bspwm-dots`**
>
> *I now use Fedora KDE with my minimal terminal configs and KDE configs*

# Installation

* `fast-install` - git pulls (recursively) and symlinks necessary configs only
```bash
chmod +x fast-install
./fast-install
```

* via `ansible` - a more complete installation that includes installing packages, etc. 
```bash
# TODO: this ansible installation docs
```

### Details

- Neovim + Tmux + Kitty
- Zsh as main shell

### Ansible (Personal Guide)

- decrypt file > decrypted_mp ([see ansible README](./ansible/README.md))
- run `devinit`

#### !! WARNING: If you want to go this route, carefully see the steps below:

1. Before installing, check the `group_vars/all.yml`
   - go to `group_vars/all.yml` -> substitute your own `ssh`, `gpg` fields
     - create password file and encrypt for ssh and gpg as encrypted string ([see ansible README](./ansible/README.md))

## Install Whole BSPWM Rice Configuration (X11)

- Clone repository and install script

```bash
git clone https://github.com/ejsadiarin/dotfiles
```

- Navigate to dotfiles

```bash
cd ~/dotfiles/
```

- Make executable

```bash
chmod +x ExquisiteInstaller
```

- Execute script

```bash
./ExquisiteInstaller
```

**Git and SSH-agent**

- `Git`

  - `git config --global user.name "NAME_HERE"` & `git config --global user.email "EMAIL_HERE"`
  - check it with: `git config user.name` & `git config user.email`

- `SSH keys and SSH-agent`

  - Read docs starting here (up to testing ssh connection): https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

## Post Installation (IMPORTANT!)

- **import and trust gpg keys**
- **zsh, neovim, and tmux plugins are 'separately installed' so we just need to open them to install the necessary plugins**

### zsh

- opening zsh will automatically install the plugins

```bash
zsh
```

### neovim

- opening nvim will also automatically install the plugins
  - do a `:checkhealth` after to see 'missing' deps, etc.

```bash
nvim
```

### tmux

- open tmux

```bash
tmux
```

- source the .tmux.conf file inside tmux

```bash
cd
tmux source .tmux.conf
```

- then install plugins with `<prefix>+I`

  - this config uses `M-Space` (or `Alt-Space`) as prefix
  - so do: `M-Space + I` (`Alt-Space + I`)

