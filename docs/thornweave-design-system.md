# ⬡ Thornweave Design System

> *Where Celtic iron meets electric sigil — and roses grow through circuit boards*

A dark-mode design system converging **technology**, **Celtic mythology**, and **fantasy** (Frieren-inspired arcane aesthetics) with motifs of thorns, roses, and runic circuitry.

---

## Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Color Palette](#color-palette)
   - [Backgrounds & Surfaces](#backgrounds--surfaces)
   - [Text Hierarchy](#text-hierarchy)
   - [Circuit — Teal](#circuit--teal)
   - [Arcane — Violet](#arcane--violet)
   - [Briar — Rose/Crimson](#briar--rosecrimson)
   - [Gilt — Celtic Gold](#gilt--celtic-gold)
   - [Thorn — Emerald](#thorn--emerald)
3. [Semantic Mapping](#semantic-mapping)
4. [Terminal Colors (16-color)](#terminal-colors-16-color)
5. [Typography](#typography)
6. [Spacing & Radius](#spacing--radius)
7. [Neovim Syntax Mapping](#neovim-syntax-mapping)
8. [Usage Targets](#usage-targets)

---

## Design Philosophy

Thornweave draws from three converging sources:

| Pillar | Influence | Expression |
|--------|-----------|------------|
| **Technology** | Circuit traces, silicon, terminals | Teal glows, monospace type, grid patterns |
| **Celtic Fantasy** | Knotwork, runes, gilded manuscripts | Gold accents, knot dividers, runic symbols |
| **Arcane / Frieren** | Mist-magic, slow-burning spells | Violet hazes, dreamy glows, spectral opacity |
| **Briar & Rose** | Thorns, crimson roses, organic danger | Rose/crimson for tension, emerald for growth |

All four live in a **deep abyss dark** — near-black with a violet undertone — that lets each accent color breathe and glow without washing out.

---

## Color Palette

### Backgrounds & Surfaces

| Token | Hex | Use |
|-------|-----|-----|
| `bg-abyss` | `#080610` | Deepest background, window chrome, tabline fill |
| `bg-base` | `#0F0C1A` | Main editor / page background |
| `bg-surface` | `#171224` | Panels, sidebars, cards |
| `bg-raised` | `#1F1830` | Floating elements, popups, hover states |
| `bg-overlay` | `#27203D` | Borders, dividers, inactive tabs |
| `bg-mist` | `#312849` | Subtle highlights, indent guides (active) |

### Text Hierarchy

| Token | Hex | Use |
|-------|-----|-----|
| `text-rune` | `#EDE8F8` | Primary text — slightly cool white, not pure |
| `text-vellum` | `#B0A8CC` | Secondary / labels / subtext |
| `text-faded` | `#6C6280` | Muted / comments / placeholders |
| `text-specter` | `#3A3050` | Disabled / line numbers (inactive) |

---

### Circuit — Teal

*The technology thread. Electrical traces etched through stone.*

| Token | Hex | Use |
|-------|-----|-----|
| `circuit-bright` | `#00E5FF` | Functions, links, cursor, active borders, focus rings |
| `circuit-mid` | `#00B8CC` | Operators, LSP indicator, secondary accents |
| `circuit-dim` | `#009EC7` | Dimmed UI chrome, inactive circuit elements |
| `circuit-muted` | `#4A9DAD` | Subtle UI elements, inactive states, secondary indicators |
| `circuit-deep` | `#003D4D` | Deep background tint for circuit-themed panels |
| `circuit-glow` | `rgba(0,229,255,0.18)` | Box-shadow glow for circuit elements |

### Arcane — Violet

*Frieren-style magic mist. Spells compiled at the boundary of code and myth.*

| Token | Hex | Use |
|-------|-----|-----|
| `arcane-bright` | `#C084FC` | Keywords (`if`, `for`, `return`), selections, special highlights |
| `arcane-mid` | `#8B3FCC` | Properties, object members, secondary magic accents |
| `arcane-dim` | `#511A80` | Visual selection background, indent scope |
| `arcane-muted` | `#9A7CC4` | Subtle UI elements, inactive states, secondary indicators |
| `arcane-deep` | `#280D40` | Deep bg tint for arcane panels |
| `arcane-glow` | `rgba(192,132,252,0.16)` | Box-shadow glow for arcane/keyword elements |

### Briar — Rose/Crimson

*Thorns guard the gate. Crimson roses in the dark.*

| Token | Hex | Use |
|-------|-----|-----|
| `briar-bright` | `#FF4D8D` | Errors, constants, destructive actions, dramatic accents |
| `briar-mid` | `#CC2563` | Self/this, static members, delete diff |
| `briar-dim` | `#7A1038` | Borders on danger elements |
| `briar-muted` | `#C0607A` | Subtle UI elements, inactive states, secondary indicators |
| `briar-deep` | `#3D0A1C` | Error/danger panel background |
| `briar-glow` | `rgba(255,77,141,0.18)` | Box-shadow glow for briar/error elements |

### Gilt — Celtic Gold

*Gilded manuscript. Runes pressed in hammered bronze.*

| Token | Hex | Use |
|-------|-----|-----|
| `gilt-bright` | `#FFD166` | Numbers, floats, booleans (secondary), warnings, which-key labels |
| `gilt-mid` | `#C9930A` | Types, interfaces, classes, enums, decorators |
| `gilt-dim` | `#7A5800` | Dimmed type/warning chrome |
| `gilt-muted` | `#D4A843` | Subtle UI elements, inactive states, secondary indicators |
| `gilt-deep` | `#3D2B00` | Warning/change diff background |
| `gilt-glow` | `rgba(255,209,102,0.16)` | Box-shadow glow for gilt/warning elements |

### Thorn — Emerald

*The thornwood grows. Nature threading through the machine.*

| Token | Hex | Use |
|-------|-----|-----|
| `thorn-bright` | `#22D98E` | Strings, success states, git add, hints |
| `thorn-mid` | `#0FA864` | Secondary strings, doc comments (special), success dimmed |
| `thorn-dim` | `#086640` | Borders on success elements |
| `thorn-muted` | `#5ABF92` | Subtle UI elements, inactive states, secondary indicators |
| `thorn-deep` | `#042D1C` | Success/add diff background |
| `thorn-glow` | `rgba(34,217,142,0.15)` | Box-shadow glow for thorn/success elements |

---

## Semantic Mapping

| Role | Token | Hex |
|------|-------|-----|
| Primary interactive | `circuit-bright` | `#00E5FF` |
| Keyword / magic | `arcane-bright` | `#C084FC` |
| Success / strings | `thorn-bright` | `#22D98E` |
| Warning / numbers | `gilt-bright` | `#FFD166` |
| Danger / errors | `briar-bright` | `#FF4D8D` |
| Types / classes | `gilt-mid` | `#C9930A` |
| Properties | `arcane-mid` | `#8B3FCC` |
| Comments | `text-faded` | `#6C6280` |
| Constants | `briar-bright` | `#FF4D8D` |
| Operators | `circuit-mid` | `#00B8CC` |

---

## Terminal Colors (16-color)

Maps to the standard 16-color terminal palette (used by Kitty, Ghostty, and `term_colors = true` in Neovim).

| Slot | Name | Hex | Mapped to |
|------|------|-----|-----------|
| 0 | Black (dark) | `#1F1830` | `bg-raised` |
| 1 | Red | `#FF4D8D` | `briar-bright` |
| 2 | Green | `#22D98E` | `thorn-bright` |
| 3 | Yellow | `#FFD166` | `gilt-bright` |
| 4 | Blue | `#009EC7` | `circuit-dim` |
| 5 | Magenta | `#8B3FCC` | `arcane-mid` |
| 6 | Cyan | `#00B8CC` | `circuit-mid` |
| 7 | White | `#B0A8CC` | `text-vellum` |
| 8 | Bright Black | `#27203D` | `bg-overlay` |
| 9 | Bright Red | `#FF4D8D` | `briar-bright` |
| 10 | Bright Green | `#22D98E` | `thorn-bright` |
| 11 | Bright Yellow | `#FFD166` | `gilt-bright` |
| 12 | Bright Blue | `#00E5FF` | `circuit-bright` |
| 13 | Bright Magenta | `#C084FC` | `arcane-bright` |
| 14 | Bright Cyan | `#00E5FF` | `circuit-bright` |
| 15 | Bright White | `#EDE8F8` | `text-rune` |

### Kitty / Ghostty config

```ini
background            #080610
foreground            #EDE8F8
selection_background  #511A80
selection_foreground  #EDE8F8
cursor                #00E5FF
cursor_text_color     #080610
url_color             #00B8CC

color0   #1F1830
color1   #CC2563
color2   #0FA864
color3   #C9930A
color4   #009EC7
color5   #8B3FCC
color6   #00B8CC
color7   #B0A8CC
color8   #27203D
color9   #FF4D8D
color10  #22D98E
color11  #FFD166
color12  #00E5FF
color13  #C084FC
color14  #00E5FF
color15  #EDE8F8

active_tab_background   #1F1830
active_tab_foreground   #00E5FF
inactive_tab_background #0F0C1A
inactive_tab_foreground #6C6280
```

---

## Typography

| Role | Family | Notes |
|------|--------|-------|
| **Display / Headings** | `Cinzel` | Roman-Celtic monumental caps; use for titles, section headers, mode labels |
| **Body / Prose** | `Spectral` | Literary serif; elegant italic; ideal for documentation and descriptions |
| **Monospace / Code** | `JetBrains Mono` or `Fira Code` | Terminal, editor, inline code; supports ligatures |

```css
--tw-font-display: 'Cinzel', serif;
--tw-font-body:    'Spectral', Georgia, serif;
--tw-font-mono:    'JetBrains Mono', 'Fira Code', monospace;
```

---

## Spacing & Radius

```css
/* Spacing scale */
--tw-space-1:  0.25rem;   /*  4px */
--tw-space-2:  0.5rem;    /*  8px */
--tw-space-3:  0.75rem;   /* 12px */
--tw-space-4:  1rem;      /* 16px */
--tw-space-6:  1.5rem;    /* 24px */
--tw-space-8:  2rem;      /* 32px */
--tw-space-12: 3rem;      /* 48px */
--tw-space-16: 4rem;      /* 64px */

/* Border radius */
--tw-radius-sm: 3px;
--tw-radius-md: 6px;
--tw-radius-lg: 12px;
--tw-radius-xl: 20px;
```

---

## Neovim Syntax Mapping

How each Thornweave color maps to Treesitter / LSP highlight groups:

| Color | Syntax Roles |
|-------|-------------|
| `arcane-bright` `#C084FC` | `@keyword`, `@conditional`, `@repeat`, `@keyword.return`, `@boolean` |
| `arcane-mid` `#8B3FCC` | `@keyword.import`, `@property`, `@variable.member`, `@field` |
| `circuit-bright` `#00E5FF` | `@function`, `@function.call`, `@function.method`, `@constructor` |
| `circuit-mid` `#00B8CC` | `@operator`, `@function.builtin`, `@punctuation.special` |
| `gilt-mid` `#C9930A` | `@type`, `@type.builtin`, `@attribute`, `@lsp.type.class`, `@lsp.type.interface`, `@lsp.type.enum` |
| `gilt-bright` `#FFD166` | `@number`, `@float`, `@namespace`, `@module`, which-key labels |
| `thorn-bright` `#22D98E` | `@string`, `@character` |
| `thorn-mid` `#0FA864` | `@string.regex`, `@string.special.symbol`, `@comment.note` |
| `gilt-bright` `#FFD166` | `@string.escape`, `@string.special` (escape sequences stay gold) |
| `briar-bright` `#FF4D8D` | `@constant`, `@constant.macro`, `@lsp.type.enumMember`, errors |
| `briar-mid` `#CC2563` | `@variable.builtin`, `@self`, `@lsp.mod.static` |
| `text-rune` `#EDE8F8` | `@variable`, normal text |
| `text-vellum` `#B0A8CC` | `@variable.parameter`, `@parameter` |
| `text-faded` `#6C6280` | `@comment`, `@punctuation`, `@punctuation.bracket` |

### Diagnostic colors

| Severity | Foreground | Undercurl |
|----------|-----------|-----------|
| Error | `#FF4D8D` briar-bright | `#FF4D8D` |
| Warning | `#FFD166` gilt-bright | `#FFD166` |
| Info | `#00E5FF` circuit-bright | `#00E5FF` |
| Hint | `#22D98E` thorn-bright | `#22D98E` |

### Diff colors

| State | Background |
|-------|-----------|
| Add | `#042D1C` thorn-deep |
| Change | `#3D2B00` gilt-deep |
| Delete | `#3D0A1C` briar-deep |
| Text (in change) | `#7A5800` gilt-dim |

---

## Usage Targets

### Linux DE (Hyprland / Waybar)

```ini
# Hyprland border colors
col.active_border   = 0xff00E5FFee 0xffC084FCee 45deg
col.inactive_border = 0xff27203Dff

# Waybar GTK
@define-color accent  #00E5FF;
@define-color accent2 #C084FC;
@define-color warning #FFD166;
@define-color danger  #FF4D8D;
@define-color success #22D98E;
@define-color bg      #0F0C1A;
@define-color surface #171224;
@define-color border  #27203D;
```

### CSS Custom Properties (Web Apps)

```css
:root {
  /* Backgrounds */
  --tw-bg-abyss:   #080610;
  --tw-bg-base:    #0F0C1A;
  --tw-bg-surface: #171224;
  --tw-bg-raised:  #1F1830;
  --tw-bg-overlay: #27203D;
  --tw-bg-mist:    #312849;

  /* Text */
  --tw-text-rune:    #EDE8F8;
  --tw-text-vellum:  #B0A8CC;
  --tw-text-faded:   #6C6280;
  --tw-text-specter: #3A3050;

  /* Accent colors */
  --tw-circuit: #00E5FF;
  --tw-arcane:  #C084FC;
  --tw-gilt:    #FFD166;
  --tw-briar:   #FF4D8D;
  --tw-thorn:   #22D98E;

  /* Typography */
  --tw-font-display: 'Cinzel', serif;
  --tw-font-body:    'Spectral', Georgia, serif;
  --tw-font-mono:    'JetBrains Mono', 'Fira Code', monospace;
}
```

### Neovim quick-reference

```lua
-- Color reference shorthand
local tw = {
  keyword  = "#C084FC",  -- arcane-bright
  func     = "#00E5FF",  -- circuit-bright
  string   = "#22D98E",  -- thorn-bright
  number   = "#FFD166",  -- gilt-bright
  constant = "#FF4D8D",  -- briar-bright
  type     = "#C9930A",  -- gilt-mid
  property = "#8B3FCC",  -- arcane-mid
  operator = "#00B8CC",  -- circuit-mid
  comment  = "#6C6280",  -- text-faded
  fg       = "#EDE8F8",  -- text-rune
  bg       = "#0F0C1A",  -- bg-base
  -- Muted variants (subtle UI, inactive states)
  circuit_muted = "#4A9DAD",
  arcane_muted  = "#9A7CC4",
  briar_muted   = "#C0607A",
  gilt_muted    = "#D4A843",
  thorn_muted   = "#5ABF92",
}
```

---

*Thornweave v1.0 · dark mode only · Celtic × Tech × Fantasy × Briar*
