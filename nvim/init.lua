-- ############################################
-- #    Install `lazy.nvim` plugin manager    #
-- ############################################
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- ##############################
-- #    CONFIGURE LAZY SETUP    #
-- ##############################
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--

-- Here are essentials
require 'essentials.autocommands'
require 'essentials.options'
require 'essentials.globals'
require 'essentials.keymaps'

-- require('lazy').setup(spec, opts)
require('lazy').setup({
  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  --  Here are extension plugin configurations for optional things (ex. Copilot)
  -- { import = 'extensions.copilot' },
  -- { import = 'extensions.avante' },
  -- { import = 'extensions.copilot-chat' },
  { import = 'extensions.cloak' },
  { import = 'extensions.flash' },
  -- { import = 'extensions.overseer' },
  -- { import = 'extensions.obsidian' },
  { import = 'extensions.oil' },
  -- { import = 'extensions.bufferline' },
  { import = 'extensions.colorizer' },
  { import = 'extensions.markview' },

  -- "mark-style" file navigation (only choose one)
  -- { import = 'extensions.harpoon' },
  { import = 'extensions.grapple' },

  -- is replaced by snacks.nvim:
  -- { import = 'extensions.noice' },
  -- { import = 'extensions.lazygit' },
  -- { import = 'extensions.vim-fugitive' },

  -- Newer alternatives
  -- { import = 'fzf-lua' }, -- alternative to telescope
  -- { import = 'blink-cmp' }, -- alternative to nvim-cmp

  -- This is the easiest way to modularize your config.
  --
  -- NOTE: For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'plugins' },

  -- Here are specific programming language module configurations (uncomment to enable)
  { import = 'extensions.go' },
  { import = 'extensions.yaml-json' },
  { import = 'extensions.markdown' },
  { import = 'extensions.java' },
  { import = 'extensions.csharp' },
  { import = 'extensions.webdev' },
  -- { import = 'extensions.python' },
  { import = 'extensions.sql' },
}, {
  defaults = {
    lazy = false,
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
    size = {
      height = 0.8,
      width = 0.8,
    },
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.cmd.colorscheme 'monokai-pro-machine'
