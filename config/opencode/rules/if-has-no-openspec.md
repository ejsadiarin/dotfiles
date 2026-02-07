### Supplementary Documentation (Optional with OpenSpec)

Use these for work outside OpenSpec workflow or additional context:

#### logs/ Directory (Optional)

Create logs for significant work not captured in OpenSpec changes:

**When to create logs/ entries:**

- Major architectural changes that span multiple OpenSpec changes
- Critical debugging sessions worth documenting separately
- Infrastructure migrations or major refactors
- Important decisions that need standalone documentation

**Format:** `logs/<timestamp>-<title>.md`

- Timestamp format: `YYYYMMDD-HHMM`
- Title: kebab-case summary (e.g., `migrate-to-postgres`, `refactor-api-layer`)

**Log content:**

- Brief summary of what changed
- Why the change was made
- Files affected (key files only)
- Follow-up tasks or considerations

#### Project-Specific Files:

- **PLAN.md** - High-level project plan, goals, milestones (optional with OpenSpec)
- **AGENTS.md** - Project-specific AI instructions and context (committed to git)

### Without OpenSpec (Fallback Method)

For projects not using OpenSpec, use traditional state management:

- **PLAN.md** - High-level project plan, goals, milestones, and current phase
- **AGENTS.md** - Project-specific instructions and context (committed to git)
- **logs/** - Directory containing timestamped change logs (REQUIRED without OpenSpec)

#### Change Logging (No OpenSpec):

When making major changes, create a log entry:

1. Ensure `logs/` directory exists in project root
2. Create file with naming based on project structure:
    - **If PLAN.md has phases:** `logs/<timestamp>-phase<X>-<title>.md`
        - Example: `logs/20260127-1430-phase1-add-auth-system.md`
    - **If no phases in PLAN.md:** `logs/<timestamp>-<title>.md`
        - Example: `logs/20260127-1430-add-auth-system.md`
    - Timestamp format: `YYYYMMDD-HHMM`
    - Title: kebab-case summary

3. Log file should include:
    - Brief summary of what changed
    - Why the change was made
    - Files affected (list key files, not every file)
    - Follow-up tasks or considerations

#### When to Log (No OpenSpec):

- Phase/milestone completions
- Major feature implementations
- Significant refactors or architecture changes
- Breaking changes
- Important bug fixes
- Configuration or infrastructure changes

Do NOT log for minor changes like typo fixes, small tweaks, or routine edits.

#### Updating Project State (No OpenSpec):

After major changes, update:

- **PLAN.md** - mark completed milestones, update current phase
- **AGENTS.md** - if the change affects how the project should be worked on
