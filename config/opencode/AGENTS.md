# Global Instructions

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

# Personal preferences and workflow instructions

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

**IMPORTANT: Make small, atomic commits based on completed task.**

**This workflow applies regardless of whether OpenSpec or any spec-driven-development framework is used.**

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

### Important Rules

- **DO NOT push commits** - user will push manually after review
- Always verify changes compile/run before committing
- Include affected files summary in commit body for significant changes
- Use present tense ("add feature" not "added feature")
- Keep subject line under 72 characters
- Do not add emojis unless stated otherwise

### (IF using OpenSpec) Commit Per Task Section

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
