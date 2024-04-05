---
id: scripting-wizardry
aliases: []
tags:
  - Linux
  - Bash
  - Scripting
date: 2024-02-18T00:04
title: Scripting Wizardry
---
<!-- 2024-02-18-0004 (February 18, 2024 12:04 AM) -->

# Scripting Wizardry - The Only Practical Guide You'll Ever Need
- become a wizard in the terminal/shell

## The only important things to know in order to get comfortable
 
1. Use pipe/piping/pipelines `|` and subshells `$()`
2. Use scripts and aliases for fast and easy executables
3. Use man pages or tldr for quick reference
4. Use "game-changers" like fzf, grep (or rg), find (or fd), awk, sed, xargs, etc.

- `|` (pipe) is used to send the output of one command to another command.
  - **stdout** of the first command becomes **stdin** of the second command.
- `$()` is used to run a command and return the output.
- `;` is used to run multiple commands in a single line.

## Examples (and useful oneliners):
```bash
# finds all my custom scripts prefixed with comma and fzf it
fd -tf -tx --glob ",*" --search-path $HOME -x basename {} | awk '!seen[$0]++' | fzf
# or (but slower)
find $HOME -type f -executable -name ",*" -exec basename {} \; | awk '!seen[$0]++' | fzf

# finds all custom scripts with fzf --preview (extensible with a custom script)
fd -tf -tx --glob ",*" --search-path $HOME/vault/wizardry/scripts-magic-spells | awk '!seen[$0]++' | fzf --header "Select script to cat" --preview 'head -$LINES {}'

# fzf all commands in system and see its documentation via man pages
compgen -c | fzf | xargs man

# kubernetes to describe pods selected via fzf
kubectl get pods -A --no-headers | fzf | awk '{print $2, $1}' | xargs -n 2 sh -c 'kubectl describe pod $0 -n $1'

# find largest files in $HOME directory (disk usage/storage)
du -ah $HOME | sort -hr | head -n 10

# find and remove ALL node_modules in a given path ($HOME in this case)
find $HOME -name "node_modules" -type d -prune -exec rm -rf {} \;

# find and remove SELECTED node_modules via fzf with preview
find $HOME -name "node_modules" -type d | \
  xargs du -sh | \
  sort -hr |
  fzf -m --header "Select which ones to delete" --preview 'cat $(dirname {})/package.json' | \
  awk '{print $2}' | \
  xargs -r -rm -rf

# list top 10 most used commands (ranks them by usage with usage preview on the left)
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10

# find empty files in a directory
find $HOME -type f -size 0
```

## Error Handling
- Exit status: `0` - success, `1` - failure
- `set -e` at the beginning of the script:
  - This will cause the script to exit immediately if a command fails. (return non-zero exit status)
  - lifehack, but cannot echo for custom error messages/feedback to stdout.

- `command || { echo "Error message; exit 1; }`
  - if `command` fails, then `echo` will run and exit.
  ```bash
  sudo umount "$mountpoint" || {
    echo "[ ERROR ] Unable to unmount the device."
    exit 1
  }
  ```

- `$? -ne 0`
  - if exit status (`$?`) is `n`ot `e`qual to `0` then do something.
  - this is simplified by `set -e`:
  ```bash
  sudo eject "$usbdisk"
  if [ $? -ne 0 ]; then
    echo "[ ERROR ] Unable to eject the device."
  fi
  ```

- `if ! command; then`
```bash
if ! sudo eject "$usbdisk"; then
  echo "[ ERROR ] Unable to eject the device."
fi
```

### `if` flags:
`-e`:
Checks if a file exists.
Example: [ -e file.txt ]

`-n`:
Checks if a string is not empty.
Example: [ -n "$variable" ]

`-z`:
Checks if a string is empty.
- if empty, return `true` (0)
Example: [ -z "$variable" ]

`-d`:
Checks if a path exists and is a directory.
Example: [ -d /path/to/directory ]

`-f`:
Checks if a path exists and is a regular file.
Example: [ -f file.txt ]

`-r`:
Checks if a file is readable.
Example: [ -r file.txt ]

`-w`:
Checks if a file is writable.
Example: [ -w file.txt ]

`-x`:
Checks if a file is executable.
Example: [ -x script.sh ]

`-s`:
Checks if a file is not empty (has a size greater than zero).
Example: [ -s file.txt ]

- usage:
```bash
if [ -<flag> <condition> ]; then
    # do something
fi
```

# References and Best Resources
- [Become a shell wizard in ~12 mins](https://www.youtube.com/watch?v=IYZDIhfAUM0)
- [Bash Scripting Pro Course in 30 mins](https://www.youtube.com/watch?v=4ygaA_y1wvQ)
- [Advanced Bash Scripting Guide: an in-depth exploration of the art of shell scripting](https://hangar118.sdf.org/p/bash-scripting-guide/index.html)
- [Some collection of scripts in Reddit](https://www.reddit.com/r/sysadmin/comments/rs4546/any_scripts_you_guys_have_that_make_your_life_so/)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Unofficial Bash Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
