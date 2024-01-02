# Installation
- git clone gh0st dot files
- install other packages:
```bash
sudo -S pacman copyq redshift auto-cpufreq
```

1. git clone the dotfiles
- with --recursive flag
2. cd to dotfiles then git pull origin main
3. git submodule update --recursive -remote
4. git commit -am "update to latest"
5. git push origin main

## Install Nvim configs
- cd to dotfiles
<details>
  <summary>Instructions For Users:</summary>
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
  <summary>Instructions For Me:</summary>
  - create a symlink to `~/.config/nvim`
    ```bash
    ln -s ~/dotfiles/nvim ~/.config/nvim
    ```
  - open nvim to install plugins
    ```bash
    nvim
    ```
</details>

## Install Tmux configs
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

## Install Zsh configs

