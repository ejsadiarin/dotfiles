# Ansible Playbook

- `full_config.yml` - for full dotfiles configuration (desktops: Fedora, Arch)
- `terminal_config.yml` - for terminal configuration only (**homelab servers: Ubuntu Server 26.04 LTS**)
- `bootstrap_debian_server.yml` - server hardening (user, sshd, fail2ban, ufw) for Ubuntu/Debian servers

## Homelab server (Ubuntu Server 26.04 LTS) quickstart

On a fresh server (logged in as your sudo user, `git` installed):

```bash
git clone https://github.com/ejsadiarin/dotfiles.git ~/dotfiles
cd ~/dotfiles/ansible
./init_node_setup                                   # ansible + collections + submodules
gpg -d master_password.gpg > master_password
ansible-playbook --vault-password-file ./master_password --ask-become-pass terminal_config.yml
```

Ubuntu-specific behavior:

- NetworkManager is skipped (Ubuntu Server uses netplan/systemd-networkd).
- Time sync keeps Ubuntu's default chrony (with NTS); only the timezone is set.
- Neovim and Go come from the latest upstream releases (distro versions are too old for the config).
- Docker CE comes from download.docker.com (`resolute` suite, deb822 source + signed-by key).
- `fdfind`/`batcat` are linked to `~/.local/bin/fd` and `~/.local/bin/bat`.
- Tailscale comes from pkgs.tailscale.com (`resolute` suite); authenticate afterwards with `sudo tailscale up`.
- Role task files for this family are named `ubuntu.yml`, but are selected with `machine_os == 'debian'`
  (the Ansible `os_family`, which covers Ubuntu and Debian). Ubuntu-only differences check
  `ansible_facts['distribution'] == 'Ubuntu'`.
- Ubuntu 26.04 uses `sudo-rs` as `sudo`, which breaks `--ask-become-pass` (ansible times out waiting
  for its prompt). `init_node_setup` switches the `sudo` alternative to classic `sudo.ws`
  (revert: `sudo update-alternatives --auto sudo`), and `inventory/hosts.ini` sets
  `ansible_become_exe=sudo.ws` for `homelab_group` so remote runs work too.

## Install Ansible on your local machine

> [!NOTE]
> Python and pipx (better than pip) is required to run `ansible`

- Make sure to install python and pipx via your package manager first

- Use `pipx` (Recommended)
    - Keeps Ansible isolated.
        - use `--include-deps` to expose other binaries like `ansible-playbook,` etc.

    ```bash
    pipx install --include-deps --force ansible
    # Install passlib for password hashing support
    pipx inject ansible passlib
    ```

## Run on localhost

- `full_config.yml`:

```bash
# run init_node_setup script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_node_setup
./init_node_setup

# run full_config playbook
ansible-playbook --vault-password-file ./master_password --ask-become-pass full_config.yml

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass full_config.yml
```

- `terminal_config.yml`:

```bash
# run init_node_setup script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_node_setup
./init_node_setup

# run terminal_config playbook
ansible-playbook --vault-password-file ./master_password --ask-become-pass terminal_config.yml

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass terminal_config.yml
```

## Run on remotes

> [!NOTE]
> Just add `-e "target_connection=ssh target_hosts=<HOST_GROUP_SEE_hosts_ini_FILE>"`

- `full_config.yml`:

```bash
# run init_node_setup script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_node_setup
./init_node_setup

# run full_config playbook
ansible-playbook --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini full_config.yml -e "target_connection=ssh target_hosts=<HOST_GROUP_SEE_hosts_ini_FILE>"

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini full_config.yml -e "target_connection=ssh target_hosts=<HOST_GROUP_SEE_hosts_ini_FILE>"
```

- `terminal_config.yml`:

```bash
# run init_node_setup script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_node_setup
./init_node_setup

# run terminal_config playbook (change target_hosts value)
ansible-playbook --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini -e "target_connection=ssh target_hosts=homelab_group" terminal_config.yml

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini terminal_config.yml
```

---

## Run `bootstrap_debian_server.yml`

- For new VPS/VMs/servers

> [!IMPORTANT]
> Override `user_name` and `user_password`

```bash
# replace user_name and user_password variables
ansible-playbook --ask-become-pass bootstrap_debian_server.yml -i inventory/hosts.ini -e "user_name=USERNAME user_password=YOUR_SECURE_PASSWORD"
```

- if you used `ansible-vault` to encrypt something, then add `--ask-vault-pass` flag:

    ```bash
    ansible-playbook --ask-become-pass --ask-vault-pass bootstrap_debian_server.yml -i ./inventory/hosts.ini -e "user_name=USERNAME user_password=YOUR_SECURE_PASSWORD"
    ```

---

# master_password

- encrypted with gpg --symmetric (first layer)
    - `--symmetric` so no need for asymmetric gpg keys
- then encrypted with ansible-vault (second layer)

- decrypt:

```bash
# decrypt with gpg symmetric key
gpg -d master_password.gpg > master_password
```

- encrypt:

```bash
# simplest way
gpg --symmetric master_password
rm master_password

# or use shred
# NOTE: might not be effective on filesystems that are:
# - RAID-based
# - log-structured/journaled filesystems with AIX and Solaris (and JFS, ReiserFS, XFS, Ext3, etc.)
# - snapshot (copy on write) like BTRFS, Network Appliance's NFS server
# - file systems that cache in temporary locations, such as NFS version 3 clients
# - compressed file systems
# see 'man shred' for more details
gpg --symmetric master_password
shred -uvz master_password
```

## Ansible Vault Encryption (via `ansible-vault`)

- encrypting a string with encrypt_string

```bash
ansible-vault encrypt_string --vault-password-file ~/dotfiles/ansible/master_password "string to encrypt" --name "VERY_SECRET_VARIABLE_NAME"
```

- encrypting files (ssh keys, gpg keys, etc.) with encrypt_string

```bash
cat file.key | ansible-vault encrypt_string --vault-password-file ~/dotfiles/ansible/master_password --stdin-name "file.key"
```

---

# Post-Installation

- **import and trust gpg keys**
- **zsh, neovim, and tmux plugins are 'separately installed' so we just need to open them to install the necessary plugins**

## gpg keys

```bash
gpg --import public.gpg
gpg --import private.gpg # will prompt for password
gpg --edit-key <email> # will prompt for password
# then in the gpg-shell:
trust
5 # ultimate
y # confirm
save
exit # if save did not exit you to the gpg-shell
```

## zsh

- opening zsh will automatically install the plugins

```bash
zsh
```

## neovim

- opening nvim will also automatically install the plugins
    - do a `:checkhealth` after to see 'missing' deps, etc.

```bash
nvim
```

## tmux

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

---

#### quickie

```bash
gpg -d master_password.gpg > master_password
ansible-playbook --vault-password-file ./master_password --ask-become-pass full_config.yml
```

#### dry run

```bash
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass full_config.yml
```
