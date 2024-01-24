# Installation
- git clone gh0st dotfiles
- install essential packages (just search how):
  - `git`
  - `nvim`
  - `tmux`
  - `fzf`
  - `fd`
  - `rg`
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

- Go:
<details>
<summary>Go: (Go is a first class citizen in this config)</summary>
-https://docs.docker.com/engine/install/linux-postinstall/

  ```bash
  sudo pacman -S docker docker-compose
  paru -S docker-desktop
  ```
  - create the `docker` group (IF NECESSARY):
  ```
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
  ```
  docker ps
  docker-compose ps
  ```
</details>

- Kubernetes:
  - [minikube](https://minikube.sigs.k8s.io/docs/start/):
- Terraform:
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
  - login to docker
  ```bash
  docker login -u <username>
  ```
</details>

<details>
<summary>Dotnet (C#/.NET):</summary>

- Install .NET Packages
  ```
  sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime
  ```

- Install EF Core globally
  ```bash
  dotnet tool install --global dotnet-ef
  ```
- if in Linux, add /.dotnet/tools to PATH in ~/.bashrc or ~/.zshrc or any shell resource configs
  ```bash
  export PATH="$PATH:$HOME/.dotnet/tools"
  ```
- Verify install of dotnet-ef
  ```bash
  dotnet ef
  ```
---------------------------------------------------------------
</details>
<details>
<summary>PostgreSQL:</summary>

- Install PostgreSQL
- PostgreSQL (details: https://wiki.archlinux.org/title/PostgreSQL):
  ```bash
  sudo -S pacman postgresql
  ```
  - run postgres user:
  ```bash
  sudo -iu postgres
  ```
  - Initialize database cluster for PostgreSQL to function correctly:
  ```bash
  initdb --locale=C.UTF-8 --encoding=UTF8 -D /var/lib/postgres/data --data-checksums
  ```
  - Start and Enable the `postgresql.service` via systemctl:
  ```bash
  systemctl start postgresql.service
  systemctl enable postgresql.service
  ```

  - Create a database and Access the database shell
    - Become the postgres user.
    - Then add a new database role / user (optional, postgres user by default):
    ```bash
    [postgres]$ createuser --interactive
    ```
    - Then create a database:
    ```bash
    createdb myDatabaseName
    ```
    - If did not work: add `-U postgres` to the previous command
    - Access the database shell:
    ```bash
    psql -d myDatabaseName
    ```
    - Some helpful commands (inside postgres shell):
    Get help:
    ```bash
    => \help

    # List all databases:

    => \l

    # Connect to a particular database:

    => \c database

    # List all users and their permission levels:

    => \du

    # Show summary information about all tables in the current database:

    => \dt

    # Exit/quit the psql shell:

    => \q

    # or press Ctrl+d.

    # There are of course many more meta-commands, but these should help you get started. To see all meta-commands run:

    => \?
    ```
  - MORE INFO ON THE ARCH WIKI: https://wiki.archlinux.org/title/PostgreSQL
---------------------------------------------------------------
</details>

- Ansible:

- Python:

- .NET:

- Networking tools:
  - `nmap`
  - `netstat`
  - `netcat`


# UPDATE: January 23, 2024 10:45 PM (HAPPY BIRTHDAY TO ME!!!!!!!)
- shifted focus on infrastructure, cloud engineering, devops, and SRE (configs baby i love it)
- the best yaml engineer kekw

