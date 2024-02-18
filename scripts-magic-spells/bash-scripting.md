---
title: Bash Scripting
date: 2024-02-18-0004 (February 18, 2024 12:04 AM)
tags:
- Linux
- Bash
- Scripting
---

# Bash Scripting

- Exit status: `0` - success, `1` - failure

## Error Handling
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
