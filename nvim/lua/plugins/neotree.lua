-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

--
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   group = vim.api.nvim_create_augroup('remove-neotree-file', { clear = true }),
--   callback = function()
--     local current_tab = vim.fn.tabpagenr()
--     vim.cmd 'tabdo wincmd ='
--     vim.cmd('tabnext ' .. current_tab)
--   end,
-- })

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
  init = function()
    -- Hijacking netrw when loading neo-tree lazily (Better netrw hijacking)
    -- see issue: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1247
    -- see fix: https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#hijacking-netrw-when-loading-neo-tree-lazily
    vim.api.nvim_create_autocmd('BufNewFile', {
      group = vim.api.nvim_create_augroup('RemoteFile', { clear = true }),
      callback = function()
        local f = vim.fn.expand '%:p'
        for _, v in ipairs { 'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync' } do
          local p = v .. '://'
          if string.sub(f, 1, #p) == p then
            vim.cmd [[
          unlet g:loaded_netrw
          unlet g:loaded_netrwPlugin
          runtime! plugin/netrwPlugin.vim
          silent Explore %
        ]]
            vim.api.nvim_clear_autocmds { group = 'RemoteFile' }
            break
          end
        end
      end,
    })
  end,
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
    event_handlers = {
      -- auto-close neo-tree on file open
      {
        event = 'file_open_requested',
        -- event = 'file_open',
        handler = function()
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- If you set this to `true`, all "hide" just mean "dimmed out"
        hide_dotfiles = false,
        hide_gitignored = true,
        -- hide_hidden = false, -- for Windows (use Linux bro)
      },
      bind_to_cwd = false,
      hijack_netrw_behavior = 'disabled', -- 'open_default', 'open_current', 'disabled'
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      -- window = {
      --   mappings = {
      --     ['\\'] = 'close_window',
      --   },
      -- },
    },
  },
}
