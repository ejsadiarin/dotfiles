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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>cd', function()
  vim.diagnostic.open_float { border = 'single' } -- enable border on diagnostic float window
end, { desc = 'Line [D]iagnostics' })

-- Open Lazy (:Lazy)
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open [L]azy' })

-- Open Mason (:Mason)
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open [M]ason' })

-- Open LspInfo (:LspInfo)
vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<CR>', { desc = 'Open [L]SP Info' })

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
