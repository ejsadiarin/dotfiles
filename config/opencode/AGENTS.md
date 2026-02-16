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

## OpenSpec Integration

This workflow integrates with OpenSpec for spec-driven development. OpenSpec handles the planning layer while this workflow handles execution.

### When OpenSpec is Available

Check if the project uses OpenSpec by looking for `openspec/` directory. If present:

#### For New Features or Changes:

1. **Start with OpenSpec**: Use `/opsx:new <feature-name>` to create change folder
2. **Generate Planning Artifacts**: Use `/opsx:ff` to generate:
    - `proposal.md` - Why and what we're building
    - `specs/` - Delta specs (ADDED/MODIFIED/REMOVED requirements)
    - `design.md` - Technical approach and architecture decisions
    - `tasks.md` - Implementation checklist
3. **Implement Following Tasks**: Work through `tasks.md` checklist
4. **Commit After Each Task**: Follow git workflow below (commit per completed task)
5. **Archive When Complete**: Use `/opsx:archive` to merge specs and archive change

#### For Brownfield/Existing Projects:

- Use `/opsx:onboard` on first OpenSpec initialization to scan codebase
- OpenSpec's delta specs (ADDED/MODIFIED/REMOVED) are perfect for documenting changes to existing systems
- No need to document entire codebase upfront - focus on what's changing
- Delta specs show exactly what's being modified vs. current behavior

#### OpenSpec Structure:

```
openspec/
├── specs/              # Source of truth (current system behavior)
│   └── <domain>/
│       └── spec.md
├── changes/            # Active work (one folder per change)
│   └── <change-name>/
│       ├── proposal.md
│       ├── design.md
│       ├── tasks.md
│       └── specs/      # Delta specs
└── changes/archive/    # Completed changes with full context
    └── YYYYMMDD-<change-name>/
```

#### Relationship Between OpenSpec and This Workflow:

| Concern                                     | Handled By                                                    |
| ------------------------------------------- | ------------------------------------------------------------- |
| Planning, specs, proposals, task generation | **OpenSpec** (`openspec/` directory)                          |
| Git commits, coding style, file operations  | **This workflow** (all sections below)                        |
| Change documentation and context            | **Both** (OpenSpec archives changes, logs/ for supplementary) |

### When OpenSpec is NOT Available

Fall back to traditional workflow with PLAN.md and logs/ (see "Project State Management" below).

### Notes on OpenSpec Usage:

- **OpenSpec manages change lifecycle**: Proposal → Specs → Design → Tasks → Archive
- **You still commit frequently**: After each task completion, follow git workflow
- **logs/ becomes optional**: OpenSpec archives provide change history
- **Coding style unchanged**: All Code Changes, File Operations sections still apply
- **Use OpenSpec commands via AI**: Commands like `/opsx:new`, `/opsx:ff`, `/opsx:apply`, `/opsx:archive`

## Project State Management

### With OpenSpec (Primary Method)

When `openspec/` directory exists, OpenSpec manages the spec-driven workflow:

- **openspec/specs/** - Source of truth for system behavior (updated via archive)
- **openspec/changes/** - Active features/fixes (one folder per change)
- **openspec/changes/archive/** - Completed changes with proposals, specs, designs, tasks

OpenSpec handles change tracking through its archive system. All context is preserved.

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
