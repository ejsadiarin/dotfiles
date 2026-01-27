# Global Instructions

Personal preferences and workflow instructions that apply to all OpenCode sessions.

## Communication Style

- Be concise and direct in responses
- Avoid unnecessary preamble or filler text
- Skip obvious explanations unless asked
- Use technical terminology appropriate for experienced developers

## Workflow Preferences

- Prefer editing existing files over creating new ones
- Always verify file exists before attempting to edit
- When making changes, show only the relevant diff context
- Ask clarifying questions if requirements are ambiguous

## Code Changes

- Make minimal, focused changes that address the specific request
- Avoid refactoring unrelated code unless explicitly asked
- Preserve existing patterns and conventions in the codebase
- Test changes mentally before proposing them

## File Operations

- Check for existing similar files/patterns before creating new ones
- Respect .gitignore and don't modify ignored files unless asked
- Be cautious with destructive operations (delete, overwrite)

## Project State Management

Projects may contain the following files for tracking state and context:

- **PLAN.md** - high-level project plan, goals, milestones, and current phase
- **AGENTS.md** - project-specific instructions and context (committed to git)
- **logs/** - directory containing timestamped change logs

### Change Logging

When making major changes (phase transitions, feature completions, significant refactors, architecture decisions), create a log entry:

1. Ensure `logs/` directory exists in project root
2. Create a new file with naming based on project structure:
    - **If PLAN.md has phases:** `logs/<timestamp>-phase<X>-<title>.md`
      - Example: `logs/20260127-1430-phase1-add-auth-system.md`
    - **If no phases in PLAN.md:** `logs/<timestamp>-<title>.md`
      - Example: `logs/20260127-1430-add-auth-system.md`
    - Timestamp format: `YYYYMMDD-HHMM`
    - Title: kebab-case summary (e.g., `add-auth-system`, `refactor-api-layer`)
3. Log file content should include:
    - Brief summary of what changed
    - Why the change was made
    - Files affected (list key files, not every file)
    - Any follow-up tasks or considerations

### When to Log

- Phase/milestone completions
- Major feature implementations
- Significant refactors or architecture changes
- Breaking changes
- Important bug fixes
- Configuration or infrastructure changes

Do NOT log for minor changes like typo fixes, small tweaks, or routine edits.

### Updating Project State

After major changes, also update:

- **PLAN.md** - mark completed milestones, update current phase
- **AGENTS.md** - if the change affects how the project should be worked on

## Git Commit Workflow

Commits are essential for rollback capability. Follow conventional commits format strictly.

### Commit After Minor Phases

After completing each minor phase (e.g., Phase 1.2, Phase 2.1) or todo, create a commit:

```
<type>(<scope>): <short description>

<detailed description of what changed and why>
```

**Types:**

- `feat` - new feature
- `fix` - bug fix
- `refactor` - code restructuring without behavior change
- `docs` - documentation only
- `test` - adding/updating tests
- `chore` - maintenance tasks, dependencies
- `perf` - performance improvement
- `style` - formatting, no code change

**Examples:**

```
feat(auth): implement google oauth login flow

- Add OAuth2 client configuration
- Create callback handler for token exchange
- Store user session in database
- Add logout endpoint
```

```
fix(api): resolve CORS validation errors

- Update allowed origins configuration
- Add preflight request handling
- Fix header validation for credentials
```

### Squash After Major Phases

After completing a major phase (e.g., all of Phase 1, Phase 2), squash all minor phase commits:

1. Count commits since last major phase: `git log --oneline`
2. Interactive rebase: `git rebase -i HEAD~<n>`
3. Mark first commit as `pick`, rest as `squash`
4. Write combined commit message:

```
feat(auth): complete authentication system [Phase 1]

Phase 1.1 - Basic setup:
- Initialize auth module structure
- Add configuration files

Phase 1.2 - Core implementation:
- Implement login/logout endpoints
- Add session management

Phase 1.3 - Testing and fixes:
- Add integration tests
- Fix edge cases
```

### Important Rules

- **DO NOT push commits** - user will push manually after review
- Always verify changes compile/run before committing
- Include affected files summary in commit body for significant changes
- Use present tense ("add feature" not "added feature")
- Keep subject line under 72 characters

## External References

For specific coding style rules (comments, formatting, etc.), refer to:
@~/.config/opencode/rules/coding-style.md
