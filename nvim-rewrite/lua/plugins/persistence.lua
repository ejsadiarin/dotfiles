-- automatically saves the active session under ~/.local/state/nvim/sessions on exit
-- simple API to restore the current or last session

return {
  -- Lua
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      -- NOTE: check :h sessionoptions
      dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
      -- minimum number of file buffers that need to be open to save
      -- Set to 0 to always save
      need = 1,
      branch = true, -- use git branch to save session
    },
    keys = function()
      -- load the session for the current directory
      vim.keymap.set('n', '<leader>r', function()
        require('persistence').load()
      end, { desc = '[R]estore session' })

      -- -- select a session to load
      -- vim.keymap.set('n', '<leader>qS', function()
      --   require('persistence').select()
      -- end)

      -- -- load the last session
      -- vim.keymap.set('n', '<leader>ql', function()
      --   require('persistence').load { last = true }
      -- end)

      -- -- stop Persistence => session won't be saved on exit
      -- vim.keymap.set('n', '<leader>qd', function()
      --   require('persistence').stop()
      -- end)
    end,
  },
}
