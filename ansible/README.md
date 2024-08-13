# master_password

- encrypted with gpg --symmetric (first layer)
  - `--symmetric` so no need for asymmetric gpg keys
- then encrypted with ansible-vault (second layer)

why did i do this double encryption? i also don't foking know, but why not?

- decrypt:

```bash
# decrypt first layer with gpg
gpg -d master_password.gpg > master_password
# decrypt second layer with ansible-vault vault password
ansible-vault view master_password > decrypted_mp
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

# Post-Installation

- zsh, neovim, and tmux plugins are 'separately installed' so we just need to open them to install the necessary plugins

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

```bash
cd
tmux source .tmux.conf
```
