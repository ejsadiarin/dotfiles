# Installation
- git clone gh0st dotfiles
- install essential packages (just search how):
  - `git`
  - `nvim`
  - `tmux`
  - `fzf`
  - `fd`
  - `rg`
  - `btop` - superior system monitoring tool
  - [`smug`](https://github.com/ivaaaan/smug) - tmux session manager written in Go
- install other packages:
  - `copyq`
  - `redshift`
  - `auto-cpufreq`
  - `flameshot`
  - `shotwell`
- Arch:
```bash
sudo -S pacman copyq redshift auto-cpufreq flameshot shotwell
```

1. git clone the dotfiles:
```bash
git clone https://github.com/ejsadiarin/dotfiles
```

<!-- TODO: make this into a script -->
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
    configs (only if you `git pull` regularly)</summary>

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
    - by default, prefix is `ctrl + b`
    - in my configs prefix is: `alt + space`

  ## Symlink everything
  ```bash
  chmod +x ~/dotfiles/symlink-install
  ~/dotfiles/symlink-install
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

## Enable Alacritty Transparency
```toml
# ... existing configs ... #
[window]
decorations = "none"
dynamic_title = true
opacity = 0.9 # change this to your liking (i like it 0.8)
# ... existing configs ... #
```

## Install Zsh configs

## Install Development Tools and other useful things (Personal)
<details>
<summary>Go: (Go is a first-class citizen in this config)</summary>
  - Install:
  - Put in PATH:
  - Check:
</details>

<details>
<summary>Docker:</summary>

- source: https://docs.docker.com/engine/install/linux-postinstall/

  ```bash
  sudo pacman -S docker docker-compose
  paru -S docker-desktop
  ```
  - create the `docker` group (IF NECESSARY):
  ```bash
  sudo groupadd docker
  ```
  - add to user to docker group
  ```bash
  # check user
  echo $USER
  sudo usermod -aG docker $USER
  # log out and log back in to save (can also reboot if necessary)
  # check if docker is in groups:
  groups
  ```
  - start/enable docker.service
  ```bash
  sudo systemctl enable docker.service
  ```
- check docker commands by running `docker --help` or `docker-compose --help` or `man docker`
  some useful commands:
  ```bash
  docker ps
  docker-compose ps
  ```
</details>

- .NET:
- Terraform:
- Kubernetes:
- Ansible:
- Python:
- Networking tools:
  - `nmap`
