# Ansible Playbook

`terminal_only_minimal.yml` - for servers, and machines with no GUI


# master_password

- encrypted with gpg --symmetric (first layer)
  - `--symmetric` so no need for asymmetric gpg keys
- then encrypted with ansible-vault (second layer)

why did i do this double encryption? i also don't foking know, but why not?

- decrypt:

```bash
# decrypt with gpg symmetric key
gpg -d master_password.gpg > master_password
```

- encrypt:

```bash
# simplest way
rm decrypted_mp
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
shred -uvz decrypted_mp
gpg --symmetric master_password
shred -uvz master_password
```

- encrypting a string with encrypt_string

```bash
ansible-vault encrypt_string --vault-password-file ~/dotfiles/ansible/decrypted_mp "string to encrypt" --name "VERY_SECRET_VARIABLE_NAME"
```

- encrypting files (ssh keys, gpg keys, etc.) with encrypt_string

```bash
cat file.key | ansible-vault encrypt_string --vault-password-file ~/dotfiles/ansible/decrypted_mp --stdin-name "file.key"
```

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
