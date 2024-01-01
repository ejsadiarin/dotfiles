return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      -- Fonts
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1
      -- Themes
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
      vim.g.gruvbox_material_statusline_style = "mix"
      -- Custom highlights
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

      vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 500,
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
      -- hls_highlight = "red",
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      contrast_dark = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {
        -- dark palette
        dark0_hard = "#1d2021", -- bg0_h
        dark0 = "#282828", -- bg0
        dark1 = "#3c3836", -- bg1
        dark2 = "#504945", -- bg2
        dark3 = "#665c54", -- bg3
        dark4 = "#7c6f64", -- bg4
        light0_hard = "#f9f5d7", -- fg0_h
        light0 = "#fbf1c7", -- fg0
        light1 = "#ebdbb2", -- fg1
        light2 = "#d5c4a1", -- fg2
        light3 = "#bdae93", -- fg3
        light4 = "#a89984", -- fg4
        bright_red = "#fb4934", -- red
        bright_green = "#b8bb26", -- green
        bright_yellow = "#fabd2f", -- yellow
        bright_blue = "#83a598", -- blue
        bright_purple = "#d3869b", -- purple
        bright_aqua = "#8ec07c", -- aqua
        bright_orange = "#fe8019", -- orange
        dark_red_hard = "#792329", -- dark_red_hard
        dark_green_hard = "#5a633a", -- dark_green_hard
        dark_aqua_hard = "#3e4934", -- dark_aqua_hard
        gray = "#4E4944", -- gray

        -- not included in dark palette?
        neutral_red = "#cc241d", -- neutral_red
        neutral_green = "#98971a", -- neutral_green
        neutral_yellow = "#d79921", -- neutral_yellow
        neutral_blue = "#458588", -- neutral_blue
        neutral_purple = "#b16286", -- neutral_purple
        neutral_aqua = "#689d6a", -- neutral_aqua
        neutral_orange = "#d65d0e", -- neutral_orange
        faded_red = "#9d0006", -- faded_red
        faded_green = "#79740e", -- faded_green
        faded_yellow = "#b57614", -- faded_yellow
        faded_blue = "#076678", -- faded_blue
        faded_purple = "#8f3f71", -- faded_purple
        faded_aqua = "#427b58", -- faded_aqua
        faded_orange = "#af3a03", -- faded_orange
      },
      overrides = {
        -- ref: https://github.com/ellisonleao/gruvbox.nvim/blob/477c62493c82684ed510c4f70eaf83802e398898/lua/gruvbox.lua#L288
        -- practical ref for highlight groups in rose pine: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/theme.lua
        -- :hi [highlightname] guifg=[color]
        ["@lsp.type.method"] = { fg = "#8ec07c" },
        ["@lsp.type.function"] = { fg = "#8ec07c" },
        ["@comment"] = { fg = "gray" },
        ["@tag"] = { fg = "#8ec07c" },
        ["@tag.delimiter"] = { fg = "#83a598" },
        ["@tag.attribute"] = { fg = "#fabd2f" },
        ["@method"] = { fg = "#8ec07c" },
        ["@symbol"] = { fg = "#d3869b" },
        ["@operator"] = { fg = "#8ec07c" },
        ["@field"] = { fg = "#f2cfcf" },
        ["@property"] = { fg = "#f2cfcf" },
        ["@variable"] = { fg = "#f9f5d7" },
        ["@function.builtin"] = { fg = "#689d6a" },
        -- ["@function.macro"] = { fg = "#fb4934" },
        ["@punctuation.delimiter"] = { fg = "#d3869b" },
        ["@punctuation.bracket"] = { fg = "#d3869b" },
        -- ["@punctuation.special"] = { fg = "#fb4934" },
        ["@type"] = { fg = "#fabd2f" },
        ["@type.builtin"] = { fg = "#fe8019" },
        ["@type.definition"] = { fg = "#fabd2f" },
        ["@type.qualifier"] = { fg = "#fabd2f" },
        ["@constant"] = { fg = "#fabd2f" },
        -- ["@constant"] = { fg = "#fabd2f" },
        -- ["@constant.builtin"] = { link = "Special" }
        Normal = { bg = "#1d2021" },
        NormalFloat = { bg = "#1d2021" },
        NormalNC = { bg = "#1d2021" },
        Special = { fg = "#8ec07c" }, -- includes custom components for React
        MsgArea = { bg = "#1d2021" },
        Pmenu = { bg = "#1d2021" },
        PmenuSel = { bg = "#3c3836", fg = "#8ec07c" },
        typescriptDocRef = { fg = "#fe8019" },
        typescriptDocName = { fg = "#fe8019" },
        typescriptDocDesc = { fg = "#fe8019" },
        typescriptDocA = { fg = "#fe8019" },
        -- NormalNC       xxx guifg=#fbf1c7
        -- MsgSeparator   xxx links to StatusLine
        -- NormalFloat    xxx guifg=#ebdbb2 guibg=#1d2021
        -- MsgArea        xxx cleared
        -- FloatBorder    xxx links to WinSeparator
        -- Comment = { bg = "#1d2021" },
        -- WinBar = { fg = "#fbf1c7", bg = "#282828" },
        -- WinBarNC = { fg = "#bdae93", bg = "#3c3836" },
        ["FidgetTask"] = { bg = "#1d2021" },
        ["FidgetTitle"] = { bg = "#1d2021" },

        -- rcarriga/nvim-dap-ui
        -- debugPC = { link = "DiffAdd" },
        ["DapUIVariable"] = { fg = "#8ec07c" },
        ["DapUIValue"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIFrameName"] = { link = "Normal" },
        ["DapUIThread"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIWatchesValue"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIBreakpointsInfo"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIBreakpointsCurrentLine"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIWatchesEmpty"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIWatchesError"] = { fg = "#fe4934", bg = "#1d2021" },
        ["DapUIBreakpointsDisabledLine"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUISource"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIBreakpointsPath"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIScope"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUILineNumber"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIBreakpointsLine"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIFloatBorder"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIStoppedThread"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIDecoration"] = { fg = "#fe8019", bg = "#1d2021" },
        ["DapUIModifiedValue"] = { fg = "#fe8019", bg = "#1d2021" },
        -- ["DapUIStepOver"] = { fg = "#8ec07c", bg = "#1d2021" },
        -- ["DapUIStepOut"] = { fg = "#8ec07c", bg = "#1d2021" },
        -- ["DapUIStepInto"] = { fg = "#8ec07c", bg = "#1d2021" },
        -- ["DapUIStepBack"] = { fg = "#8ec07c", bg = "#1d2021" },
        ["DapUIStepOverNC"] = { bg = "#1d2021" },
      },
      dim_inactive = true,
      transparent_mode = true,
    },
  },

  -- enable transparency so it will background will be the color of the terminal
  -- ref: https://github.com/xiyaowong/transparent.nvim
  -- command: :TransparentEnable --> will cached and transparent will be applied
  {
    "xiyaowong/transparent.nvim",
    opts = {
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
      },
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    },
  },

  -- {
  --   "eddyekofo94/gruvbox-flat.nvim",
  --   priority = 1000,
  --   enabled = true,
  --   config = function()
  --     vim.g.gruvbox__transparent = true
  --     -- vim.cmd.colorscheme("gruvbox-flat")
  --   end,
  --   -- opts = {},
  -- },

  {
    "luisiacc/gruvbox-baby",
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  -- Catppuccin lol
  --   {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "mocha",
  --     transparent_background = true,
  --     integrations = {
  --       alpha = true,
  --       cmp = true,
  --       flash = true,
  --       gitsigns = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       noice = true,
  --       notify = true,
  --       neotree = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       which_key = true,
  --     },
  --   },
  -- },
}
