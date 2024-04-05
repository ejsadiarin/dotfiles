local latte = require("catppuccin.palettes").get_palette("latte")
local frappe = require("catppuccin.palettes").get_palette("frappe")
local macchiato = require("catppuccin.palettes").get_palette("frappe")
local mocha = require("catppuccin.palettes").get_palette("mocha")

local colors = require("catppuccin.palettes").get_palette() -- current flavour's palette

return {
  -- Catppuccin the GOAT
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {
          mocha = {
            -- CUSTOM:
            base = "#050517",

            -- DEFAULT mocha for reference:
            -- rosewater = "#f5e0dc",
            -- flamingo = "#f2cdcd",
            -- pink = "#f5c2e7",
            -- mauve = "#cba6f7",
            -- red = "#f38ba8",
            -- maroon = "#eba0ac",
            -- peach = "#fab387",
            -- yellow = "#f9e2af",
            -- green = "#a6e3a1",
            -- teal = "#94e2d5",
            -- sky = "#89dceb",
            -- sapphire = "#74c7ec",
            -- blue = "#89b4fa",
            -- lavender = "#b4befe",
            -- text = "#cdd6f4",
            -- subtext1 = "#bac2de",
            -- subtext0 = "#a6adc8",
            -- overlay2 = "#9399b2",
            -- overlay1 = "#7f849c",
            -- overlay0 = "#6c7086",
            -- surface2 = "#585b70",
            -- surface1 = "#45475a",
            -- surface0 = "#313244",
            -- base = "#1e1e2e",
            -- mantle = "#181825",
            -- crust = "#11111b",
          },
        },
        custom_highlights = function(cp)
          return {
            -- Example (see: https://github.com/ayamir/nvimdots/wiki/Usage#get-catppuccin-colors for more):
            -- LspReferenceText = { bg = colors.bg_highlight },
            -- LspReferenceRead = { bg = colors.bg_highlight },
            -- LspReferenceWrite = { bg = colors.bg_highlight },
            -- LspDiagnosticsDefaultError = { fg = colors.red },
            -- LspDiagnosticsDefaultWarning = { fg = colors.yellow },
            -- LspDiagnosticsDefaultInformation = { fg = colors.blue },
            -- LspDiagnosticsDefaultHint = { fg = colors.cyan },
            -- Comment = { fg = colors.flamingo },
            -- TabLineSel = { bg = colors.pink },
            -- CmpBorder = { fg = colors.surface2 },
            -- Pmenu = { bg = colors.none },
            -- Normal = { bg = "#050517" },
            -- TODO: move this to highlight_overrides:
            WhichKeyFloat = { bg = "#0f0f24" },
            WhichKeyBorder = { bg = "#89b4fa" },
            LazyNormal = { bg = "#050517" },
            TroubleNormal = { bg = "" },
            MasonNormal = { bg = "#050517" },
            NormalFloat = { bg = cp.base },
            -- htmlBold = { fg = "rose" },
            -- markdownBold = { fg = "rose" },
            -- NeoTreeNormal = { bg = "#050517" },
            -- StatusLine = { bg = "#050517" },
            -- lualine_a_insert = { bg = "#050517" },
            ["@constant.builtin"] = { fg = cp.peach, style = {} },
            ["@comment"] = { fg = cp.surface2, style = { "italic" } },
          }
        end,
        highlight_overrides = {
          mocha = function(c)
            return {
              NeoTreeNormal = { bg = c.base },
              -- HarpoonNormal = { bg = c.base },
            }
          end,
        },
        -- default_integrations = false,
        integrations = {
          alpha = true,
          cmp = true,
          flash = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          noice = true,
          notify = true,
          neotree = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          -- which_key = true,
        },
      })
    end,
  },

  -- Gruvbox the GOAT
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      -- Fonts
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 0
      vim.g.gruvbox_material_transparent_background = 1
      -- Themes
      vim.g.gruvbox_material_foreground = "mix" -- "original", "mix", "material" (use "mix" if too bright)
      vim.g.gruvbox_material_background = "hard" -- "hard", "medium", "soft" (use "hard" if too bright)
      vim.g.gruvbox_material_ui_contrast = "high" -- "low", "high" The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim" -- "bright", "dim" Background of floating windows
      vim.g.gruvbox_material_statusline_style = "default" -- "default", "mix", "original"
      -- vim.g.gruvbox_material_disable_terminal_colors = 1
      -- Custom highlights
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      -- by default := transparent ? 'grey background' : 'bold'
      vim.g.gruvbox_material_current_word = "grey background"

      -- vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
    end,
  },

  -- original gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    },
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    opts = {
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        -- Alternatively, set all headings at once.
        -- headings = "subtle",
      },

      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
        WhichKeyFloat = { bg = "#050517" },
        WhichKeyBorder = { bg = "#89b4fa" },
        LazyNormal = { bg = "#050517" },
        TroubleNormal = { bg = "" },
        -- htmlBold = { fg = "rose" },
        -- markdownBold = { fg = "rose" },
        -- NeoTreeNormal = { bg = "#050517" },
        -- StatusLine = { bg = "#050517" },
        -- lualine_a_insert = { bg = "#050517" },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls (FIX: not working kekw)
        if highlight.undercurl then
          highlight.undercurl = false
        end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
          -- colors.bg_sidebar = "#0099ff"
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors)
          highlights.TelescopeNormal = {
            bg = colors.bg_dark,
            fg = colors.fg_dark,
          }
          highlights.TelescopeBorder = {
            bg = colors.bg_dark,
            fg = "",
          }
          highlights.TelescopePromptNormal = {
            bg = colors.bg_dark,
            fg = colors.fg,
          }
          highlights.TelescopePromptBorder = {
            bg = colors.bg_dark,
            fg = colors.red,
          }
          highlights.TelescopePromptTitle = {
            bg = colors.bg_dark,
            fg = colors.green,
          }
          highlights.TelescopePreviewTitle = {
            bg = colors.bg_dark,
            fg = colors.fg,
          }
          highlights.TelescopeResultsBorder = {
            bg = colors.bg_dark,
            fg = colors.fg,
          }
          highlights.TelescopeResultsTitle = {
            bg = colors.bg_dark,
            fg = colors.green,
          }
          highlights.FloatBorder = {
            bg = colors.bg_dark,
            fg = colors.green,
          }
          -- @markup.raw.markdown_inline = {
          --   bg = "",
          --   fg = colors.green,
          -- }
        end,
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- set default colorscheme here
      colorscheme = "catppuccin-mocha",
    },
  },
}

-- Gruvbox (heavily modified)
-- {
--   "ellisonleao/gruvbox.nvim",
--   priority = 500,
--   config = true,
--   opts = {
--     terminal_colors = true, -- add neovim terminal colors
--     undercurl = true,
--     underline = true,
--     bold = true,
--     italic = {
--       strings = false,
--       emphasis = true,
--       comments = true,
--       operators = false,
--       folds = true,
--     },
--     -- hls_highlight = "red",
--     strikethrough = true,
--     invert_selection = false,
--     invert_signs = false,
--     invert_tabline = false,
--     invert_intend_guides = false,
--     inverse = true, -- invert background for search, diffs, statuslines and errors
--     contrast = "hard", -- can be "hard", "soft" or empty string
--     contrast_dark = "hard", -- can be "hard", "soft" or empty string
--     palette_overrides = {
--       -- dark palette
--       dark0_hard = "#1d2021", -- bg0_h
--       dark0 = "#282828", -- bg0
--       dark1 = "#3c3836", -- bg1
--       dark2 = "#504945", -- bg2
--       dark3 = "#665c54", -- bg3
--       dark4 = "#7c6f64", -- bg4
--       light0_hard = "#f9f5d7", -- fg0_h
--       light0 = "#fbf1c7", -- fg0
--       light1 = "#ebdbb2", -- fg1
--       light2 = "#d5c4a1", -- fg2
--       light3 = "#bdae93", -- fg3
--       light4 = "#a89984", -- fg4
--       bright_red = "#fb4934", -- red
--       bright_green = "#b8bb26", -- green
--       bright_yellow = "#fabd2f", -- yellow
--       bright_blue = "#83a598", -- blue
--       bright_purple = "#d3869b", -- purple
--       bright_aqua = "#8ec07c", -- aqua
--       bright_orange = "#fe8019", -- orange
--       dark_red_hard = "#792329", -- dark_red_hard
--       dark_green_hard = "#5a633a", -- dark_green_hard
--       dark_aqua_hard = "#3e4934", -- dark_aqua_hard
--       gray = "#4E4944", -- gray
--
--       -- not included in dark palette?
--       neutral_red = "#cc241d", -- neutral_red
--       neutral_green = "#98971a", -- neutral_green
--       neutral_yellow = "#d79921", -- neutral_yellow
--       neutral_blue = "#458588", -- neutral_blue
--       neutral_purple = "#b16286", -- neutral_purple
--       neutral_aqua = "#689d6a", -- neutral_aqua
--       neutral_orange = "#d65d0e", -- neutral_orange
--       faded_red = "#9d0006", -- faded_red
--       faded_green = "#79740e", -- faded_green
--       faded_yellow = "#b57614", -- faded_yellow
--       faded_blue = "#076678", -- faded_blue
--       faded_purple = "#8f3f71", -- faded_purple
--       faded_aqua = "#427b58", -- faded_aqua
--       faded_orange = "#af3a03", -- faded_orange
--     },
--     overrides = {
--       -- ref: https://github.com/ellisonleao/gruvbox.nvim/blob/477c62493c82684ed510c4f70eaf83802e398898/lua/gruvbox.lua#L288
--       -- practical ref for highlight groups in rose pine: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/theme.lua
--       -- :hi [highlightname] guifg=[color]
--       ["@lsp.type.method"] = { fg = "#8ec07c" },
--       ["@lsp.type.function"] = { fg = "#8ec07c" },
--       ["@comment"] = { fg = "gray" },
--       ["@tag"] = { fg = "#8ec07c" },
--       ["@tag.delimiter"] = { fg = "#83a598" },
--       ["@tag.attribute"] = { fg = "#fabd2f" },
--       ["@method"] = { fg = "#8ec07c" },
--       ["@symbol"] = { fg = "#d3869b" },
--       ["@operator"] = { fg = "#8ec07c" },
--       ["@field"] = { fg = "#f2cfcf" },
--       ["@property"] = { fg = "#f2cfcf" },
--       ["@variable"] = { fg = "#f9f5d7" },
--       ["@function.builtin"] = { fg = "#689d6a" },
--       -- ["@function.macro"] = { fg = "#fb4934" },
--       ["@punctuation.delimiter"] = { fg = "#d3869b" },
--       ["@punctuation.bracket"] = { fg = "#d3869b" },
--       -- ["@punctuation.special"] = { fg = "#fb4934" },
--       ["@type"] = { fg = "#fabd2f" },
--       ["@type.builtin"] = { fg = "#fe8019" },
--       ["@type.definition"] = { fg = "#fabd2f" },
--       ["@type.qualifier"] = { fg = "#fabd2f" },
--       ["@constant"] = { fg = "#fabd2f" },
--       -- ["@constant"] = { fg = "#fabd2f" },
--       -- ["@constant.builtin"] = { link = "Special" }
--       Normal = { bg = "#1d2021" },
--       NormalFloat = { bg = "#1d2021" },
--       NormalNC = { bg = "#1d2021" },
--       Special = { fg = "#8ec07c" }, -- includes custom components for React
--       MsgArea = { bg = "#1d2021" },
--       Pmenu = { bg = "#1d2021" },
--       PmenuSel = { bg = "#3c3836", fg = "#8ec07c" },
--       typescriptDocRef = { fg = "#fe8019" },
--       typescriptDocName = { fg = "#fe8019" },
--       typescriptDocDesc = { fg = "#fe8019" },
--       typescriptDocA = { fg = "#fe8019" },
--       -- NormalNC       xxx guifg=#fbf1c7
--       -- MsgSeparator   xxx links to StatusLine
--       -- NormalFloat    xxx guifg=#ebdbb2 guibg=#1d2021
--       -- MsgArea        xxx cleared
--       -- FloatBorder    xxx links to WinSeparator
--       -- Comment = { bg = "#1d2021" },
--       -- WinBar = { fg = "#fbf1c7", bg = "#282828" },
--       -- WinBarNC = { fg = "#bdae93", bg = "#3c3836" },
--       ["FidgetTask"] = { bg = "#1d2021" },
--       ["FidgetTitle"] = { bg = "#1d2021" },
--
--       -- rcarriga/nvim-dap-ui
--       -- debugPC = { link = "DiffAdd" },
--       ["DapUIVariable"] = { fg = "#8ec07c" },
--       ["DapUIValue"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIFrameName"] = { link = "Normal" },
--       ["DapUIThread"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIWatchesValue"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIBreakpointsInfo"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIBreakpointsCurrentLine"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIWatchesEmpty"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIWatchesError"] = { fg = "#fe4934", bg = "#1d2021" },
--       ["DapUIBreakpointsDisabledLine"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUISource"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIBreakpointsPath"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIScope"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUILineNumber"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIBreakpointsLine"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIFloatBorder"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIStoppedThread"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIDecoration"] = { fg = "#fe8019", bg = "#1d2021" },
--       ["DapUIModifiedValue"] = { fg = "#fe8019", bg = "#1d2021" },
--       -- ["DapUIStepOver"] = { fg = "#8ec07c", bg = "#1d2021" },
--       -- ["DapUIStepOut"] = { fg = "#8ec07c", bg = "#1d2021" },
--       -- ["DapUIStepInto"] = { fg = "#8ec07c", bg = "#1d2021" },
--       -- ["DapUIStepBack"] = { fg = "#8ec07c", bg = "#1d2021" },
--       ["DapUIStepOverNC"] = { bg = "#1d2021" },
--     },
--     dim_inactive = true,
--     transparent_mode = true,
--   },
-- },

-- add transparency (idk if necessary with the native transparency prop for each colorscheme)
--  - enable transparency so it will background will be the color of the terminal
--  - ref: https://github.com/xiyaowong/transparent.nvim
--  - command: :TransparentEnable --> will cached and transparent will be applied
-- {
--   "xiyaowong/transparent.nvim",
--   opts = {
--     groups = { -- table: default groups
--       "Normal",
--       "NormalNC",
--       "Comment",
--       "Constant",
--       "Special",
--       "Identifier",
--       "Statement",
--       "PreProc",
--       "Type",
--       "Underlined",
--       "Todo",
--       "String",
--       "Function",
--       "Conditional",
--       "Repeat",
--       "Operator",
--       "Structure",
--       "LineNr",
--       "NonText",
--       "SignColumn",
--       "CursorLineNr",
--       "EndOfBuffer",
--     },
--     extra_groups = {}, -- table: additional groups that should be cleared
--     exclude_groups = {}, -- table: groups you don't want to clear
--   },
-- },
