# Exquisite Tmux Configuration (created: 2024-01-01, update: and here i am its 2025-01-01)

## [Installation](#installation)

1. Clone `tpm` for tmux plugins
```bash
# git clone tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

2. Install tmux plugins with `<prefix> + I`

3. Source the tmux config file:
```bash
tmux source ~/<path to .tmux.conf>

# tmux source ~/.tmux.conf
```

## [Workflow and Mappings](#workflow-and-mappings)
- `<prefix>` is `<ctrl>+a`
- most keybinds revolve around `<alt>`

* `<alt> + d` - creating new session, picking new directory, uses fzf
* `<alt> + s` - switch to an existing session, uses fzf
* `<alt> + t` - spawn new terminal pane
* `<alt> + x` - kill pane
* `<prefix> + s` - see all sessions, `+ x` to close existing session

## tmux-sensible options

```conf
####### tmux-sensible enabled options: #######

# Address vim mode switching delay (http://superuser.com/a/252717/65504)
# set -s escape-time 0

# Increase scrollback buffer size from 2000 to 50000 lines
# set -g history-limit 50000

# Increase tmux messages display duration from 750ms to 4s
# set -g display-time 4000

# Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
# set -g status-interval 5

# (OS X) Fix pbcopy/pbpaste for old tmux versions (pre 2.6)
# set -g default-command "reattach-to-user-namespace -l $SHELL"

# Upgrade $TERM
# set -g default-terminal "screen-256color"

# Emacs key bindings in tmux command prompt (prefix + :) are better than
# vi keys, even for vim users
# set -g status-keys emacs

# Focus events enabled for terminals that support them
# set -g focus-events on

# Super useful when using "grouped sessions" and multi-monitor setup
# setw -g aggressive-resize on

# Easier and faster switching between next/prev window
# bind C-p previous-window
# bind C-n next-window

# Source .tmux.conf as suggested in `man tmux`
# bind R source-file '~/.tmux.conf'

# If prefix is 'C-a'
# bind C-a send-prefix
# bind a last-window

##########################################
```
