# claude

Claude Code user config, symlinked into `~/.claude/`:

| File | Linked to |
| --- | --- |
| `settings.json` | `~/.claude/settings.json` |
| `keybindings.json` | `~/.claude/keybindings.json` |

Installed by the `claude` Ansible role (`ansible/roles/claude`, part of `full_config.yml`) or by `fast-install`.

Manual setup (Linux or macOS):

```bash
mkdir -p ~/.claude
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/keybindings.json ~/.claude/keybindings.json
```

Notes:

- `keybindings.json` only lists overrides; Claude Code merges it with its built-in defaults. Don't paste the full default list back in, or it will stop picking up new defaults. Ctrl+C and Ctrl+D are reserved and can't be rebound.
- `model: "opus"` always follows the newest Opus. `effortLevel` accepts low/medium/high/xhigh.
- Some commands (`/model`, `/config`) write to `settings.json`. If `ls -l ~/.claude/settings.json` ever shows a regular file instead of a link, copy it back here and re-link.
- MCP servers are registered at user scope (`~/.claude.json`, not tracked): Playwright via `claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest` (needs Node). Context7 is provided by the claude.ai account connector, so don't add a local copy.
