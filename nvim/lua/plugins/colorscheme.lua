-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    opts = {
      transparent_background = true,
      -- show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      -- term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 1, -- percentage of the shade to apply to the inactive window
      },
      -- no_italic = false, -- Force no italic
      -- no_bold = false, -- Force no bold
      -- no_underline = false, -- Force no underline
      -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      --   comments = { 'italic' }, -- Change the style of comments
      --   conditionals = { 'italic' },
      --   loops = {},
      --   functions = {},
      --   keywords = {},
      --   strings = {},
      --   variables = {},
      --   numbers = {},
      --   booleans = {},
      --   properties = {},
      --   types = {},
      --   operators = {},
      --   -- miscs = {}, -- Uncomment to turn off hard-coded styles
      -- },

      -- NOTE: override colors here
      color_overrides = {
        all = {},
        latte = {
          -- base = '#ff0000',
          -- mantle = '#242424',
          -- crust = '#474747',
        },
        frappe = {},
        macchiato = {},
        mocha = {},
      },

      -- NOTE: override highlight groups here
      highlight_overrides = {
        all = function(colors)
          return {
            -- NvimTreeNormal = { fg = colors.none },
            -- CmpBorder = { fg = '#3e4145' },
          }
        end,
        latte = function(latte)
          return {
            -- Normal = { fg = latte.base },
          }
        end,
        frappe = function(frappe)
          return {
            -- ['@comment'] = { fg = frappe.surface2, style = { 'italic' } },
          }
        end,
        macchiato = function(macchiato)
          return {
            -- LineNr = { fg = macchiato.overlay1 },
          }
        end,
        mocha = function(mocha)
          return {
            -- Comment = { fg = mocha.flamingo },
            -- Normal = { bg = '#050517' },
          }
        end,
      },
    },
  },

  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      -- Fonts
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1
      -- Themes
      vim.g.gruvbox_material_foreground = 'original' -- "original", "mix", "material" (use "mix" if too bright)
      vim.g.gruvbox_material_background = 'hard' -- "hard", "medium", "soft" (use "hard" if too bright)
      vim.g.gruvbox_material_ui_contrast = 'high' -- "low", "high" The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = 'dim' -- "bright", "dim" Background of floating windows
      vim.g.gruvbox_material_statusline_style = 'original' -- "default", "mix", "original"
      -- vim.g.gruvbox_material_disable_terminal_colors = 1
      -- Custom highlights
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      -- by default := transparent ? 'grey background' : 'bold'
      vim.g.gruvbox_material_current_word = 'grey background'

      -- vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
    end,
  },

  -- original gruvbox
  {
    'ellisonleao/gruvbox.nvim',
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
      contrast = 'hard', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    },
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- Enable transparent background
      transparent = true,

      -- Enable italics comments
      italic_comments = false,

      -- Replace all fillchars with ' ' for the ultimate clean look
      hide_fillchars = true,

      -- Modern borderless telescope theme - also applies to fzf-lua
      borderless_telescope = false,

      -- Set terminal colors used in `:terminal`
      terminal_colors = true,

      -- Use caching to improve performance - WARNING: experimental feature - expect the unexpected!
      -- Early testing shows a 60-70% improvement in startup time. YMMV. Disables dynamic light/dark theme switching.
      cache = false, -- generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache

      theme = {
        variant = 'auto', -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
        highlights = {
          -- Highlight groups to override, adding new groups is also possible
          -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

          -- Example:
          Comment = { fg = '#242424', bg = 'NONE', italic = true },

          -- Complete list can be found in `lua/cyberdream/theme.lua`
        },

        -- Override a highlight group entirely using the color palette
        overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
          -- Example:
          return {
            Comment = { fg = colors.green, bg = 'NONE', italic = true },
            ['@property'] = { fg = colors.magenta, bold = true },
          }
        end,

        -- Override a color entirely
        colors = {
          -- For a list of colors see `lua/cyberdream/colours.lua`
          -- Example:
          bg = '#000000',
          green = '#00ff00',
          magenta = '#ff00ff',
        },
      },

      -- Disable or enable colorscheme extensions
      extensions = {
        telescope = true,
        notify = true,
        mini = true,
      },
    },
  },
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      terminal_colors = true,
      devicons = true, -- highlight the icons of `nvim-web-devicons`
      styles = {
        comment = { italic = true },
        keyword = { italic = true }, -- any other keyword
        type = { italic = true }, -- (preferred) int, long, char, etc
        storageclass = { italic = true }, -- static, register, volatile, etc
        structure = { italic = true }, -- struct, union, enum, etc
        parameter = { italic = true }, -- parameter pass in function
        annotation = { italic = true },
        tag_attribute = { italic = true }, -- attribute of tag in reactjs
      },
      filter = 'classic', -- classic | octagon | pro | machine | ristretto | spectrum
      -- Enable this will disable filter option
      day_night = {
        enable = false, -- turn off by default
        day_filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
        night_filter = 'spectrum', -- classic | octagon | pro | machine | ristretto | spectrum
      },
      inc_search = 'background', -- underline | background
      background_clear = {
        -- "float_win",
        'toggleterm',
        'telescope',
        'which-key',
        -- 'renamer',
        'notify',
        -- "nvim-tree",
        'neo-tree',
        'bufferline', -- better used if background of `neo-tree` or `nvim-tree` is cleared
      }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = 'default', -- default | pro
          context_start_underline = false,
        },
      },
      ---@param c Colorscheme
      -- override = function(c) end,
      ---@param cs Colorscheme
      ---@param p ColorschemeOptions
      ---@param Config MonokaiProOptions
      ---@param hp Helper
      -- override = function(cs: Colorscheme, p: ColorschemeOptions, Config: MonokaiProOptions, hp: Helper) end,
    },
  },

  -- Rose Pine
  {
    'rose-pine/neovim',
    lazy = false,
    name = 'rose-pine',
    opts = {
      variant = 'auto', -- auto, main, moon, or dawn
      dark_variant = 'main', -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = 'muted',
        link = 'iris',
        panel = 'surface',

        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',

        git_add = 'foam',
        git_change = 'rose',
        git_delete = 'love',
        git_dirty = 'rose',
        git_ignore = 'muted',
        git_merge = 'iris',
        git_rename = 'pine',
        git_stage = 'iris',
        git_text = 'rose',
        git_untracked = 'subtle',

        headings = {
          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        },
        -- Alternatively, set all headings at once.
        -- headings = "subtle",
      },

      -- highlight_groups = {
      --   -- Comment = { fg = "foam" },
      --   -- VertSplit = { fg = "muted", bg = "muted" },
      --   WhichKeyFloat = { bg = '#050517' },
      --   WhichKeyBorder = { bg = '#89b4fa' },
      --   LazyNormal = { bg = '#050517' },
      --   TroubleNormal = { bg = '' },
      --   -- htmlBold = { fg = "rose" },
      --   -- markdownBold = { fg = "rose" },
      --   -- NeoTreeNormal = { bg = "#050517" },
      --   -- StatusLine = { bg = "#050517" },
      --   -- lualine_a_insert = { bg = "#050517" },
      -- },
      --
      -- before_highlight = function(group, highlight, palette)
      --   -- Disable all undercurls (FIX: not working kekw)
      --   if highlight.undercurl then
      --     highlight.undercurl = false
      --   end
      --   --
      --   -- Change palette colour
      --   -- if highlight.fg == palette.pine then
      --   --     highlight.fg = palette.foam
      --   -- end
      -- end,
    },
  },
}
