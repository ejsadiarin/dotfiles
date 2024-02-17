---
title: Useful One-liners
date: 2024-02-15-2226 (February 15, 2024 10:26 PM)
tags:
- Scripting
---
# Useful One-liners (perfect when aliased)

- **List the top 10 most used commands**
```bash
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10

# aliased in .zshrc or .bashrc:
,mostusedcommands='history | awk "{print \$2}" | sort | uniq -c | sort -nr | head -10'
```

- **Find empty files in a directory** (already in `,findempty` script)
```bash
find "$1" -type f -size 0
```
