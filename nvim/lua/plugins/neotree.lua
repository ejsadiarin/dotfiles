-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,
  -- priority = 1000,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', silent = true, desc = 'Explorer NeoTree' },
  },
  -- config = function()
  --   vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
  --   vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
  --   vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
  --   vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
  -- end,
  opts = {
    sources = { 'filesystem', 'buffers', 'git_status' },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
    filesystem = {
      filtered_items = {
        visible = true, -- If you set this to `true`, all "hide" just mean "dimmed out"
        hide_dotfiles = false,
        hide_gitignored = true,
        -- hide_hidden = false, -- for Windows (use Linux bro)
      },
      bind_to_cwd = false,
      hijack_netrw_behavior = 'open_default', -- 'open_default', 'open_current', 'disabled'
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      -- event_handlers = {
      --   -- auto-close neo-tree on file open
      --   {
      --     event = 'file_opened',
      --     handler = function()
      --       -- auto close
      --       -- vimc.cmd("Neotree close")
      --       -- OR
      --       require('neo-tree.command').execute { action = 'close' }
      --     end,
      --   },
      -- },
      -- window = {
      --   mappings = {
      --     ['\\'] = 'close_window',
      --   },
      -- },
    },
  },
}
