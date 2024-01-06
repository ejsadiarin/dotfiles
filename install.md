# Installation
- git clone gh0st dotfiles
- install essential packages (just search how):
  - `git`
  - `nvim`
  - `tmux`
  - [`smug`](https://github.com/ivaaaan/smug) - tmux session manager written in Go
- install other packages:
  - `copyq`
  - `redshift`
  - `auto-cpufreq`
  - `flameshot`
- Arch:
```bash
sudo -S pacman copyq redshift auto-cpufreq flameshot
```

1. git clone the dotfiles

## Install Terminal Configs (Nvim, Tmux, Zsh)
- cd to dotfiles
<details>
  <summary>If you want to customize the configs with your own preference(Recommended, esp. for ricers)</summary>

  - copy to your `~/.config/nvim`
    ```bash
    cp -r ~/dotfiles/nvim ~/.config/nvim
    # remove .git so you can add it to your own repo
    rm -rf ~/.config/nvim/.git
  - open nvim to install plugins
    ```bash
    nvim
    ```
</details>

<details>
  <summary>If you don't want to customize yourself (Symlinked version) - every change in this repo will change the
    configs (if you `git pull`)</summary>

  - create a symlink to `~/.config/nvim`
    ```bash
    ln -s ~/dotfiles/nvim ~/.config/nvim
    ```
  - open nvim to install plugins
    ```bash
    nvim
    ```
  - create 2 symlinks for:
    - `~/.tmux/`
    - `~/.tmux.conf`
    ```bash
    cd dotfiles
    ln -s ~/dotfiles/tmux ~/.tmux
    ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ```
  - open tmux
    ```bash
    tmux
    ```
  - git clone tpm
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
  - source tmux.conf in home directory
    ```bash
    cd
    tmux source .tmux.conf
    ```
  - go to .tmux.conf 
    ```bash
    nvim ~/.tmux.conf
    ```
  - install plugins with `prefix + I`
    - by default prefix is `ctrl + b`
    - in my configs prefix is: `ctrl + space`

  ## Symlink everything
  ```bash
  rm ~/.zshrc ~/.ideavimrc 
  ln -s ~/dotfiles/.zshrc ~/.zshrc
  ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
  rm -rf ~/.config/bspwm/bspwmrc ~/.config/bspwm/sxhkdrc
  ln -s ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc 
  ln -s ~/dotfiles/config/bspwm/sxhkdrc ~/.config/bspwm/sxhkdrc 
  ```
</details>

## Update BSPWM configs
### bspwmrc
```bash
# edit your xinput for laptop natural scrolling (google how to get your device id)
```
### sxhkdrc
### system.ini
- adapter, battery, network interface (wifi)
- if not laptop, keep battery section empty
### weather module
- in `~/.config/bspwm/scripts/Weather`
- edit: `KEY` and `CITY`
  - KEY: get from [openweathermap.org](https://openweathermap.org/)
  - CITY: find also in [openweathermap.org](https://openweathermap.org/)

## Enable Alacritty Transpacency
```toml
# ... existing configs ... #
[window]
decorations = "none"
dynamic_title = true
opacity = 0.8 # change this to your liking (i like it 0.8)
# ... existing configs ... #
```

## Install Zsh configs

## Install Development Tools
- Go:
