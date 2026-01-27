# Coding Style Rules

## Formatting

- **Respect project formatters**: always check for and respect project-level formatting configuration files:
    - `.prettierrc`, `.prettierrc.json`, `.prettierrc.js`, `prettier.config.js`
    - `.editorconfig`
    - `.eslintrc`, `.eslintrc.json`, `.eslintrc.js`
    - Language-specific formatters (e.g., `rustfmt.toml`, `pyproject.toml`, `.clang-format`)
- **Follow existing style**: when no formatter config exists, match the existing code style in the project
- **Consistency over preference**: project formatting rules take precedence over personal preferences

## Comments (Code Comments)

- **Minimal comments**: use comments sparingly and only when necessary
- **Lowercase start**: all comments must start with a lowercase letter
- **Explanatory only**: comments should explain the "why", not the "what"
- **No trivial comments**: avoid obvious comments like `// increment counter` or `// set value to 0`
- **No commented-out code**: remove commented-out code blocks instead of leaving them in
- **Self-documenting code**: prefer clear variable names and function names over explanatory comments

## Examples

### Good

```javascript
// handles edge case where user has no profile photo
if (!user.photoUrl) {
    return DEFAULT_AVATAR;
}
```

### Bad

```javascript
// Check if photoUrl exists
if (!user.photoUrl) {
    // Return default avatar
    return DEFAULT_AVATAR;
}
```

### Bad (trivial)

```javascript
// Increment i
i++;

// Set name to "John"
const name = "John";
```
