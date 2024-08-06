-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
    -- keys = { { '<leader>' } }, -- lazy load: activate only when <leader> key is pressed (twice press to see which-key menu)
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>b', group = '[B]uffer', icon = '' },
        { '<leader>d', group = '[D]ebug', icon = '' },
        { '<leader>c', group = '[C]ode', icon = ' ' },
        { '<leader>f', group = '[F]ind Files', icon = '' },
        { '<leader>n', group = '[N]otifications (Noice)' },
        { '<leader>s', group = '[S]earch', icon = '' },
        { '<leader>w', group = '[W]indow', icon = '' },
        { '<leader>u', group = '[U]I', icon = '' },
        { '<leader>g', group = '[G]it', icon = ' ' },
        { '<leader>x', group = '[X]iagnostics (Trouble)', icon = '' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },
}

-- Array = ' ',
-- Boolean = '󰨙 ',
-- Class = ' ',
-- Codeium = '󰘦 ',
-- Color = ' ',
-- Control = ' ',
-- Collapsed = ' ',
-- Constant = '󰏿 ',
-- Constructor = ' ',
-- Copilot = ' ',
-- Enum = ' ',
-- EnumMember = ' ',
-- Event = ' ',
-- Field = ' ',
-- File = ' ',
-- Folder = ' ',
-- Function = '󰊕 ',
-- Interface = ' ',
-- Key = ' ',
-- Keyword = ' ',
-- Method = '󰊕 ',
-- Module = ' ',
-- Namespace = '󰦮 ',
-- Null = ' ',
-- Number = '󰎠 ',
-- Object = ' ',
-- Operator = ' ',
-- Package = ' ',
-- Property = ' ',
-- Reference = ' ',
-- Snippet = ' ',
-- String = ' ',
-- Struct = '󰆼 ',
-- TabNine = '󰏚 ',
-- Text = ' ',
-- TypeParameter = ' ',
-- Unit = ' ',
-- Value = ' ',
-- Variable = '󰀫 ',
--
