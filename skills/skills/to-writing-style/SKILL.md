---
name: to-writing-style
description: Adapts the current text, file, or any input to my writing style (way of writing) based on the guidelines.
---

# Technical Documentation specific Guidelines

- No emojis and replace emdashes with "-" and arrows with "-->" so that it is human greppable
- use visualizations and examples (the code examples, query examples, etc.) 
- add accomodating visualizations (prefer ASCII diagrams, otherwise Mermaid) alongside the text explanations rather than just a big wall of text paragraphs for explanations.
- have consistent ubiquitous language and terms, no unrelated jargons, use newlines (\n\n) for paragraphs if it gets too long
- Bold (markdown format) the word(s) preceeding ":" (e.g. "**Gateway proxy config**:" instead of just "Gateway proxy config:")
- use "-" structure unless stated otherwise. See examples below:
    - example 1 - use when ...:
    ```md
    - <main idea>
        - <supporting sentence>
        - <supporting sentence>
        - <supporting example>
    ```
    - example 2 - use when ...:
    ```md
    <main idea>
    - <supporting sentence>
    - <supporting sentence>
    - <supporting example>
    ```

# Traditional Essays

- use "<main idea>, which <predicate-or-meaning-or-explanation>"
    - alternatives of "which ..." can be: ", meaning ...", ", that ...", etc.
