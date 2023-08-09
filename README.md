# Exquisite Configs
- Arch / EndeavourOS
- Bspwm
- Polybar
- Dunst
- Alacritty / Kitty
- Firefox
  - extensions (just log in to own profile):
    - Vimium
    - nightTab
    - AdBlock

## Initialize / Installation
* Install script
* Git and SSH-agent
`Git`
- `git config --global user.name "NAME_HERE"` & `git config --global user.email "EMAIL_HERE"`
- check it with: `git config user.name` & `git config user.email`

`SSH keys and SSH-agent`
- Read docs starting here (up to testing ssh connection): https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

### Packages

### Additional Packages to install (from AUR or source binary install)
> auto-cpufreq:
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

### Optional Apps to install
- Discord
- Zoom

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
> Install docker and docker-compose (and docker desktop if preferred) source: https://docs.docker.com/engine/install/linux-postinstall/
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

* Install .NET Packages
```
sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime
```

* Install VS Code and JetBrains Toolbox
```
paru -S 
sudo pacman -S 
```

* Install EF Core globally
```
dotnet tool install --global dotnet-ef
```
  * if in Linux, add /.dotnet/tools to PATH in ~/.bashrc or ~/.zshrc or any shell resource configs
  ```
  export PATH="$PATH:$HOME/.dotnet/tools"
  ```
  * Verify install of dotnet-ef
  ```
  dotnet ef
  ```

* Install PostgreSQL
> PostgreSQL (details: https://wiki.archlinux.org/title/PostgreSQL):
  `sudo -S pacman postgresql`
  - run postgres user:
  `sudo -iu postgres`
  - Initialize database cluster for PostgreSQL to function correctly:
  `initdb --locale=C.UTF-8 --encoding=UTF8 -D /var/lib/postgres/data --data-checksums`
  - Start and Enable the `postgresql.service` via systemctl:
  ```
  systemctl start postgresql.service
  systemctl enable postgresql.service
  ```
  > Create a database and Access the database shell
    Become the postgres user.
    - Then add a new database role / user (optional, postgres user by default):
    ```
    [postgres]$ createuser --interactive
    ```
    - Then create a database:
    `createdb myDatabaseName`
    If did not work: add `-U postgres` to the previous command
    
    Access the database shell:
    `psql -d myDatabaseName`

    Some helpful commands:
    Get help:
    ```
    => \help

    List all databases:

    => \l

    Connect to a particular database:

    => \c database

    List all users and their permission levels:

    => \du

    Show summary information about all tables in the current database:

    => \dt

    Exit/quit the psql shell:

    => \q

    or press Ctrl+d.

    There are of course many more meta-commands, but these should help you get started. To see all meta-commands run:

    => \?
    ```
  MORE INFO ON THE ARCH WIKI: https://wiki.archlinux.org/title/PostgreSQL

## How to maintain?
REMEMBER: Most problems are user generated, DON'T BREAK YOUR OWN COMPUTER (Arch itself is stable)
- Use timeshift for snapshots (backups)
- DO THIS REGULARLY (from `https://forum.endeavouros.com/t/a-complete-idiots-guide-to-endeavour-os-maintenance-update-upgrade/25184`):
```bash
// update mirrorlist via EOS welcome
update the Arch mirrors
update the EOS mirrors

// OR manually:
  // update mirrorlist
  sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist

  // update eos mirrorlist
  eos-rankmirrors --verbose

// update system
paru // or yay (depending on your AUR helper)

// clear journalctl
journalctl --vacuum-time=4weeks

// clean cache and all uninstalled packages (keep 3 versions by default)
paccache -ruk0

// remove orphans
pacman -Rns $(pacman -Qdtq)
```

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
