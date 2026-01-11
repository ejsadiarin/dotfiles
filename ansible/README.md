# Ansible Playbook

- `full_config.yml` - for full dotfiles configuration
- `terminal_config.yml` - for terminal configuration only
- `bootstrap_debian_server.yml` - for debian servers (ubuntu server, etc.)

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
# run init_control_node script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_control_node
./init_control_node

# run full_config playbook
ansible-playbook --vault-password-file ./master_password --ask-become-pass full_config.yml

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass full_config.yml
```

- `terminal_config.yml`:

```bash
# run init_control_node script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_control_node
./init_control_node

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
# run init_control_node script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_control_node
./init_control_node

# run full_config playbook
ansible-playbook --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini full_config.yml -e "target_connection=ssh target_hosts=<HOST_GROUP_SEE_hosts_ini_FILE>"

# dry-run (optional to test things first)
ansible-playbook --check --vault-password-file ./master_password --ask-become-pass -i inventory/hosts.ini full_config.yml -e "target_connection=ssh target_hosts=<HOST_GROUP_SEE_hosts_ini_FILE>"
```

- `terminal_config.yml`:

```bash
# run init_control_node script (installs ansible, dependencies, and initializes master_password with gpg)
chmod +x ./init_control_node
./init_control_node

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
ansible-playbook --ask-become-pass bootstrap_lscs_vps.yml -i inventory/hosts.ini -e "user_name=USERNAME user_password=YOUR_SECURE_PASSWORD"
```

- if you used `ansible-vault` to encrypt something, then add `--ask-vault-pass` flag:

    ```bash
    ansible-playbook --ask-become-pass --ask-vault-pass bootstrap_lscs_vps.yml -i ./inventory/hosts.ini -e "user_name=USERNAME user_password=YOUR_SECURE_PASSWORD"
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
