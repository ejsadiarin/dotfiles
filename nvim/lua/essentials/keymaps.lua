-- ###########################
-- #    ESSENTIAL KEYMAPS    #
-- ###########################
--  NOTE: these are only "essential" keymaps, plugin-specific ones aren't included here
--  See `:help vim.keymap.set()`

--  Remap normal mode to "kj" when insert mode
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- use Tab to switch cycle window
vim.keymap.set('n', '<TAB>', '<C-W>w')
vim.keymap.set('n', '<S-TAB>', '<C-W>W')
vim.keymap.set('n', '<leader>wh', '<C-W>s', { desc = '[H]orizontal Split' })
vim.keymap.set('n', '<leader>wv', '<C-W>v', { desc = '[V]ertical Split' })

-- move lines
vim.keymap.set('n', '<C-n>', '<CMD>m .+1<CR>==', { desc = 'Move line dow(n)' })
vim.keymap.set('n', '<C-p>', '<CMD>m .-2<CR>==', { desc = 'Move line u(p)' })
vim.keymap.set('i', '<C-n>', '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move line dow(n)' })
vim.keymap.set('i', '<C-p>', '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move line u(p)' })
vim.keymap.set('v', '<C-n>', ":m '>+1<CR>gv=gv", { desc = 'Move line dow(n)' })
vim.keymap.set('v', '<C-p>', ":m '<-2<CR>gv=gv", { desc = 'Move line u(p)' })

-- Switch to previous latest buffer (like ctrl+tab)
vim.keymap.set('n', '<leader><tab>', '<cmd>e #<CR>', { desc = 'Switch to latest buffer' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })
vim.keymap.set('n', '<leader>cd', function()
  vim.diagnostic.open_float { border = 'single' } -- enable border on diagnostic float window
end, { desc = 'Line [d]iagnostics' })

-- Open Lazy (:Lazy)
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open [l]azy' })

-- Open Mason (:Mason)
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open [m]ason' })

-- Open LspInfo (:LspInfo)
vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<CR>', { desc = 'Open [l]SP Info' })

-- Highlights Under Cursor
vim.keymap.set('n', '<leader>ui', vim.show_pos, { desc = 'UI: [i]nspect Pos' })
vim.keymap.set('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = 'UI: [I]nspect Tree' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<C-c>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Vertical and Horizontal Splits
vim.keymap.set('n', '<leader>wh', '<C-W>s', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>wv', '<C-W>v', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window' })

-- resize splits
vim.keymap.set('n', '<M-Left>', '<C-W>5<')
vim.keymap.set('n', '<M-Right>', '<C-W>5>')
vim.keymap.set('n', '<M-Up>', '<C-W>+')
vim.keymap.set('n', '<M-Down>', '<C-W>-')

-- changes cwd to head of current buffer (useful for grepping and finding files)
vim.keymap.set('n', '<leader>cW', function()
  -- Define the change_cwd_head_of_buffer function
  _G.utils = _G.utils or {}
  function _G.utils.change_cwd_to_head_of_buffer()
    local bufname = vim.fn.expand '%:p:h'
    vim.cmd(string.format('cd %s | echom "CWD changed to: %s"', vim.fn.fnameescape(bufname), bufname))
  end
  _G.utils.change_cwd_to_head_of_buffer()
end, { noremap = true, desc = 'Change cwd to head of current buffer', silent = false })

-- show path of current buffer
vim.keymap.set('n', '<leader>cw', function()
  -- Define the change_cwd_head_of_buffer function
  _G.utils = _G.utils or {}
  function _G.utils.show_path_of_current_buffer()
    local bufname = vim.fn.expand '%:p:h'
    vim.cmd(string.format('echom "Path: %s"', bufname))
  end
  _G.utils.show_path_of_current_buffer()
end, { noremap = true, desc = 'Show path of current buffer ', silent = false })

-- Hold v mode when indenting
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- checkbox for md (NOTE: this can be put in a custom commands file)
vim.keymap.set('n', '<leader>ch', function()
  local checked_character = 'x'
  local checked_checkbox = '%[' .. checked_character .. '%]'
  local unchecked_checkbox = '%[ %]'
  local line_contains_unchecked = function(line)
    return line:find(unchecked_checkbox)
  end
  local line_contains_checked = function(line)
    return line:find(checked_checkbox)
  end
  local line_with_checkbox = function(line)
    -- return not line_contains_a_checked_checkbox(line) and not line_contains_an_unchecked_checkbox(line)
    return line:find('^%s*- ' .. checked_checkbox)
      or line:find('^%s*- ' .. unchecked_checkbox)
      or line:find('^%s*%d%. ' .. checked_checkbox)
      or line:find('^%s*%d%. ' .. unchecked_checkbox)
  end
  local checkbox = {
    check = function(line)
      return line:gsub(unchecked_checkbox, checked_checkbox, 1)
    end,
    uncheck = function(line)
      return line:gsub(checked_checkbox, unchecked_checkbox, 1)
    end,
    make_checkbox = function(line)
      if not line:match '^%s*-%s.*$' and not line:match '^%s*%d%s.*$' then
        -- "xxx" -> "- [ ] xxx"
        return line:gsub('(%S+)', '- [ ] %1', 1)
      else
        -- "- xxx" -> "- [ ] xxx", "3. xxx" -> "3. [ ] xxx"
        return line:gsub('(%s*- )(.*)', '%1[ ] %2', 1):gsub('(%s*%d%. )(.*)', '%1[ ] %2', 1)
      end
    end,
  }
  local M = {}
  M.toggle = function()
    local bufnr = vim.api.nvim_buf_get_number(0)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local start_line = cursor[1] - 1
    local current_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ''
    -- If the line contains a checked checkbox then uncheck it.
    -- Otherwise, if it contains an unchecked checkbox, check it.
    local new_line = ''
    if not line_with_checkbox(current_line) then
      new_line = checkbox.make_checkbox(current_line)
    elseif line_contains_unchecked(current_line) then
      new_line = checkbox.check(current_line)
    elseif line_contains_checked(current_line) then
      new_line = checkbox.uncheck(current_line)
    end
    vim.api.nvim_buf_set_lines(bufnr, start_line, start_line + 1, false, { new_line })
    vim.api.nvim_win_set_cursor(0, cursor)
  end
  -- vim.api.nvim_create_user_command("ToggleCheckbox", M.toggle, {})
  -- return M
  M.toggle()
end, { desc = 'Toggle C[h]eckbox' })

-- Toggle and create folds
-- vim.keymap.set('n', '<leader>zf', 'zfaf', { silent = true, desc = 'Create fold on [f]unction' })
-- vim.keymap.set('n', '<leader>zo', 'zR', { silent = true, desc = 'Open all folds' })
-- vim.keymap.set('n', '<leader>zc', 'zM', { silent = true, desc = 'Close all folds' })
-- vim.keymap.set('n', '<leader>zd', 'zE', { silent = true, desc = 'Delete all folds (in file)' })

-- conceallevel change
vim.keymap.set('n', '<leader>uC', ':set conceallevel=', { desc = 'Change [C]onceallevel' })

-- unpolluted paste (paste from yank register)
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"0p', { desc = 'Unpolluted [p]aste' })

-- save without formatting
vim.keymap.set('n', '<leader>ccs', ':noautocmd w<CR>', { desc = 'Save without formatting' })

-- telescope select colorscheme
vim.keymap.set('n', '<leader>us', ':Telescope colorscheme<CR>', { desc = 'UI: [s]elect colorscheme' })

-- transform selected to markdown link format
-- vim.keymap.set('x', '<leader>ml', , {desc = 'Transform to markdown link'})

-- copy path to clipboard
vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%:p:h'
  if path ~= '' then
    vim.fn.setreg('+', path)
    print('Copied: ' .. path)
  end
end, { desc = 'Copy [p]ath to clipboard' })

-- center cursor when scrolling up and down via keymaps
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', '<C-D>', '<C-D>zz')

-- Buffer keymaps
vim.keymap.set('n', '<leader>bd', '<CMD>bd<CR>', { desc = 'Buffer: [d]elete' })
