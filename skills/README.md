# Third-party Skills that I use

- vercel-labs/skills - /find-skills for discovering more skills
- Leonxlnx/taste-skill - frontend/design and brand skills (pinned to v2.1.0; v2.1.5 dropped the multi-skill set)
- mattpocock/skills - planning and engineering skills (grill-me, to-tickets, tdd, ...)
- addyosmani/agent-skills - whole SDLC
- Leonxlnx/cinetic - for animated cinematic videos (e.g. app demos)
- juliobsz/skills - for /awwwards skill to create landing pages
- wheresryan22/anatomy - for 3D model of a concept. Pairs well with /awwwards (from juliobsz/skills)

## Install

From the dotfiles root, one script per tool:

```bash
./install-skills-opencode     # -> ~/.agents/skills (OpenCode, Codex, Cursor, ...)
./install-skills-mcp-claude   # -> ~/.claude/skills, plus plugins and MCP servers
```

Both clone the sources once into `${XDG_DATA_HOME:-~/.local/share}/dotfiles-skills`
(shared helpers in `scripts/lib/skills.sh`) and link each skill into their own
tool's directory, so the tools stay separate:

- Claude Code reads only `~/.claude/skills` (plus plugins), never `~/.agents/skills`.
  It prefers plugins, which Claude Code auto-updates: `mattpocock-skills`,
  `taste-skill`, `cinetic`, `awwwards` and `jury` (marketplaces are declared in
  `claude/settings.json` with `autoUpdate: true`). Only repos/skills with no plugin
  are git-cloned: `anatomy`, `find-skills`, and Matt's `misc/`/`in-progress/` skills.
  Custom skills in `skills/skills/` are linked for Claude Code too.
- OpenCode reads `~/.config/opencode/skills` (custom, `config/opencode/skills`),
  `~/.agents/skills`, and also `~/.claude/skills` (no switch to turn that off).
  Same-named skills resolve to one copy, so overlap with `~/.claude/skills` is harmless.

Flags (both scripts):

- `--force` - replace existing entries with links to the clones
  (real directories are moved to `<name>.bak.<timestamp>` first)
- `--update` - fetch the configured refs again, then relink
