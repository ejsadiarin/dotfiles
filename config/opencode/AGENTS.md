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

### Refactoring & Feature Addition

- **Extend, don't replace**: add new functionality alongside existing code rather than overwriting, unless absolutely necessary
- **Verify usage before deletion**: use grep to confirm functions/code aren't used before removing
- **Maintain backward compatibility**: don't break existing APIs, function signatures, or behavior
- **Deprecation over deletion**: if code must be removed, mark as deprecated first, don't delete immediately
- **Test existing flows**: after changes, mentally verify existing functionality still works

## File Operations

- Check for existing similar files/patterns before creating new ones
- Respect .gitignore and don't modify ignored files unless asked
- Be cautious with destructive operations (delete, overwrite)

## Git Commit Workflow

Commits are essential for rollback capability. Follow conventional commits format strictly.

**This workflow applies regardless of whether OpenSpec is used.**

### Commit After Every Change

After completing each task, todo, or minor change (e.g., "Configure TypeScript and path aliases"), create a commit immediately:

```
git commit -m "chore(config): configure typescript and path aliases"
```

For more complex changes, include a body:

```
git commit -m "chore(config): configure typescript and path aliases

- Set up tsconfig.json with strict mode
- Configure path aliases for @/* mapping to src/*
- Add tsconfig paths to webpack/vite config"
```

**When using OpenSpec:** Commit after completing each task from `tasks.md` checklist in the active change folder.

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
```

```
chore(config): configure typescript and path aliases
```

### Squash After Major Phases

After completing a major phase or OpenSpec change, optionally squash minor commits:

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

**With OpenSpec:** Consider squashing after archiving a change to create one clean commit per feature.

### Important Rules

- **DO NOT push commits** - user will push manually after review
- Always verify changes compile/run before committing
- Include affected files summary in commit body for significant changes
- Use present tense ("add feature" not "added feature")
- Keep subject line under 72 characters
- Do not add emojis unless stated otherwise

### OpenSpec Implementation: Commit Per Task Section

When implementing OpenSpec tasks, commit after completing each logical grouping of tasks (e.g., after finishing all tasks in a section like "1. Backend - SQL Queries") before proceeding to the next section.

**Example workflow:**

```markdown
## 1. Backend - SQL Queries

- [x] 1.1 Add SQL query to list API keys by member email in `query.sql`
- [x] 1.2 Add SQL query to delete API key by ID in `query.sql`
- [x] 1.3 Run `sqlc generate` to regenerate repository code

→ COMMIT HERE with message describing the SQL queries added

## 2. Backend - Repository Functions

- [x] 2.1 Implement repository function to list API keys by email
- [x] 2.2 Implement repository function to delete API key by ID

→ COMMIT HERE with message describing the repository functions
```

**Commit message format for task section completion:**

```
feat(api-key): add SQL queries and repository functions for API key management

- Add list query by member email (exclude api_key_hash)
- Add delete query by ID with member email check
- Implement list_repository and delete_repository functions
- Run sqlc generate for regenerated code
```

**Key principle:** Commit after each task section is complete, not just after every single checkbox. This creates meaningful commit history that groups related changes together while still maintaining granular rollback capability.

## External References

For specific coding style rules (comments, formatting, etc.), refer to:
@~/.config/opencode/rules/coding-style.md
