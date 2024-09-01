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
}
