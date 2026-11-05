# Third-party Skills that I use

- vercel-labs/skills - /find-skills for discovering more skills
- Leonxlnx/taste-skill - frontend/design and brand skills (pinned to v2.1.0; v2.1.5 dropped the multi-skill set)
- mattpocock/skills - planning and engineering skills (grill-me, to-tickets, tdd, ...)
- addyosmani/agent-skills - whole SDLC
- Leonxlnx/cinetic - for animated cinematic videos (e.g. app demos)
- juliobsz/skills - for /awwwards skill to create landing pages
- wheresryan22/anatomy - for 3D model of a concept. Pairs well with /awwwards (from juliobsz/skills)

## Install

From the dotfiles root:

```bash
./install-skills
```

The script clones the sources into `${XDG_DATA_HOME:-~/.local/share}/dotfiles-skills`,
then symlinks each skill into `~/.agents/skills`. OpenCode, Codex, Cursor and other
agents read that directory directly. Claude Code only reads `~/.claude/skills`, so
the script also creates per-skill links there.

- `./install-skills --force` - replace existing entries with links to the clones
  (real directories are moved to `<name>.bak.<timestamp>` first)
- `./install-skills --update` - fetch the configured refs again, then relink

