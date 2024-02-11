# Exquisite Configs
- flexible, heavenly fast, and exquisite. A beautiful crossover of practicality and aesthetics.
- mainly focused on having fast keymaps/keybindings with the least mental overhead possible

# NOTE (IMPORTANT READ):
  <!-- - this can run on any installation/distro Linux and any de/wm (except for NixOS) -->
  - my current setup (as of 2024-01-02 1:20 PM): 
    - This config on top of BSPWM with [gh0stzk dotfiles](https://github.com/gh0stzk/dotfiles)
    ![bspwm-exquisite-rice](/bspwm-best-rice.png)

### If you come from Reddit and you want to see/install the config of the image above 
1. if you just want to **SEE** the configs look here:
  - bspwmrc: [`~/dotfiles/config/bspwm/bspwmrc`](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/bspwmrc)
  - alacritty: [`~/dotfiles/config/alacritty`](https://github.com/ejsadiarin/dotfiles/tree/main/config/alacritty)
  - picom.conf: [`~/dotfiles/config/bspwm/picom.conf`](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/picom.conf)
  - sxhkdrc: [`~/dotfiles/config/bspwm/sxhkdrc`](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/sxhkdrc)
  - dunstrc: [`~/dotfiles/config/bspwm/dunstrc`](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/dunstrc)
  - scripts: [`~/dotfiles/config/bspwm/scripts`](https://github.com/ejsadiarin/dotfiles/tree/main/config/bspwm/scripts)
    - if you're going to install this, make sure to get your own API key on [openweathermap](https://openweathermap.org/api) and put it in `Weather` script for your own city.
  - [EXQUISITE rice (image above)](https://github.com/ejsadiarin/dotfiles/tree/main/config/bspwm/rices/exquisite)
    - polybar: 
      - [modules.ini](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/rices/exquisite/modules.ini)
      - [config.ini](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/rices/exquisite/config.ini)
    - eww: [`~/dotfiles/config/bspwm/eww`](https://github.com/ejsadiarin/dotfiles/tree/main/config/bspwm/eww)
    - [`Theme.sh` that powers and connects everything together](https://github.com/ejsadiarin/dotfiles/blob/main/config/bspwm/rices/exquisite/Theme.sh)

2. If you want to **INSTALL** exquisite rice (excluding nvim and tmux configs):
  - install [gh0stzk dotfiles](https://github.com/gh0stzk/dotfiles?tab=readme-ov-file#-installation) first
  - copy/replace (use `cp` or symlink it) your whole `~/.config/bspwm` for bspwm configs along with the rice config, `~/.config/alacritty` for alacritty configs, `~/.zshrc` for custom zsh (if you want the prompt) to the one in this repo [`~/dotfiles/config`](https://github.com/ejsadiarin/dotfiles/tree/main/config), [`~/dotfiles/.zshrc`](https://github.com/ejsadiarin/dotfiles/blob/main/.zshrc)


# !!! EVERYTHING BELOW IS HEAVILY W.I.P (WORK IN PROGRESS)
  - the install script is not yet fully functional, if you can try just backup your system :) 

## Pick your Wine
<!-- TODO: dropdown menu instructions -->
<!-- NOTE: put install.md here -->
> Full Window Manager setup (this configs on top of [gh0stzk dotfiles](https://github.com/gh0stzk/dotfiles))
> Standalone setup (this configs only)

### Details
- Arch / EndeavourOS
- Bspwm (X11)
- Polybar
- Dunst
- Rofi
- Alacritty / Kitty
- Brave
- Firefox

## Initialize / Installation
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

* Git and SSH-agent
`Git`
- `git config --global user.name "NAME_HERE"` & `git config --global user.email "EMAIL_HERE"`
- check it with: `git config user.name` & `git config user.email`

`SSH keys and SSH-agent`
- Read docs starting here (up to testing ssh connection): https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

## Post Installation (IMPORTANT!)
- Eww (partially DEPRECATED):
  - script doesn't install `eww-x11` because signing keys need to be imported first before building/installing
  ```bash
  curl -sS https://github.com/elkowar.gpg | gpg --import -i -
  curl -sS https://github.com/web-flow.gpg | gpg --import -i -
  ```
  - then install `eww-x11` via paru
  ```
  paru -S eww-x11
  ```
- Eww (this):
  - follow instructions on installing the binaries (not aur)

- bswpwmrc `~/.config/bspwm/bspwmrc`:
  - edit your xinput for laptop natural scrolling (google how to get your device id)

- Neovim (`nvim/`):
  - install LazyVim
  - copy contents (config and plugins directories)


### Packages
- flameshot for exquisite screenshots
  - open configs with `flameshot config`
- shotwell for proper image viewing
- copyq - clipboard manager
- redshift - redlight filter
- auto-cpufreq
- thunar - file manager

### Additional Packages to install (from AUR or source binary install)
<details>
<summary>auto-cpufreq</summary>

  ```bash
  # Install from source
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git
  cd auto-cpufreq
  sudo ./auto-cpufreq-installer
  # enable it (this does the systemctl enable):
  sudo auto-cpufreq --install

  systemctl status auto-cpufreq
  # or auto-cpufreq --stats
  ```
  - create auto-cpufreq.conf in `/etc/`:
  ```bash
  cd /etc/
  # create conf file
  sudo touch auto-cpufreq.conf
  sudo vim auto-cpufreq.conf
  ```
  - my preferred configs: `turbo = never` on powersave
--------------------------------------------------------------------
</details>

### Optional Apps to install
- Discord
- Zoom
  - in `~/.config/zoomus.conf`: set `enableMiniWindow=false` to disable floating mini window

## Pass (password manager, gpg keys, credentials, etc.)
IMPORTANT for Docker
```bash
pass
gpg --generate-key
# if you want to change expiry duration:
gpg --edit-key <generated-public-key>
expire
# you will be prompted for options (0 means no expiry, etc.)
0 # if you want
save
exit # if save did not exit you to the gpg-shell
pass init <generated-public-key>
```

-----------------------------------------------
## Development
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
* Install .NET Packages
```
sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime
```

* Install VS Code and JetBrains Toolbox (Optional)
* Install EF Core globally
<details>
<summary>Dotnet (C#/.NET)</summary>

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
<summary>PostgreSQL</summary>

### Install PostgreSQL
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

# How to maintain?

REMEMBER: Most problems are user generated, DON'T BREAK YOUR OWN COMPUTER (Arch itself is stable)
- Use timeshift for snapshots (backups)
- DO THIS REGULARLY (from `https://forum.endeavouros.com/t/a-complete-idiots-guide-to-endeavour-os-maintenance-update-upgrade/25184`):
```bash
# update mirrorlist via EOS welcome
update the Arch mirrors
update the EOS mirrors

# OR manually:
  # update mirrorlist
  sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist

  # update eos mirrorlist
  eos-rankmirrors --verbose

# update system
paru # or yay (depending on your AUR helper)

# clear journalctl
journalctl --vacuum-time=4weeks

# clean cache and all uninstalled packages (keep 3 versions by default)
paccache -ruk0

# remove orphans
pacman -Rns $(pacman -Qdtq)
```

<!-- DEPRECATED -->
### SCRIPT info
- auto move `auto-cpufreq.conf` to `/etc/`

config (~/.config/{selected_dir}):
- bspwm/
- alacritty/
- eww/
- neofetch/
- nvim/lua/config
- nvim/lua/plugins
- ranger/
- paru/
- zsh/

home (~/{selected_dir}):
- .zshrc
- .ideavimrc
- nightTab/

misc:
- Code/settings.json (different dir since this is from the vscode profile)
- applications/ranger.desktop (~/.local/share/applications/)
- bin/ (~/.local/bin/)
- firefox/ (~/.mozilla/firefox/*.default-release/) --> can be not symlinked
- fonts/ (~/.local/share/fonts/)

----
Special Thanks to gh0stzk / z0mbi3
