-- #################
-- #    OPTIONS    #
-- #################
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.termguicolors = true
vim.opt.guicursor = 'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor' -- Blinking cursor
-- vim.opt.grepprg = 'rg --vimgrep --hidden -g !.git'
-- vim.opt.grepformat = '%f:%l:%c:%m'
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver100/,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.opt.cursorline = true -- Show which line your cursor is on
-- vim.opt.pumblend = 0 -- related to autocomplete documentation bg transparent, idk not make transparent bg
-- vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Fold options
-- vim.opt.foldtext = 'v:lua.FoldText()' -- custom fold (see: lua/scripts/foldtext.lua)
-- vim.opt.foldmethod = 'indent'
-- these opts only folds all standard function blocks and not the sub-blocks inside that
-- vim.opt.foldlevel = 2
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldnestmax = 2

vim.opt.encoding = 'UTF-8'

vim.opt.number = true         -- Set numbered lines
vim.opt.relativenumber = true -- Set relative line numbers

vim.opt.hlsearch = true       -- Highlight on search
vim.opt.incsearch = true      -- While typing a search command, show where the pattern matches

vim.opt.mouse = 'a'           -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.background = 'dark'

vim.opt.showmode = true -- Show mode for exquisite simplicity

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.tabstop = 4        -- Insert 4 spaces for a tab
vim.opt.softtabstop = 4    -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.breakindent = true -- Enable break indent

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true  -- Ignore case in search patterns
vim.opt.smartcase = true   -- Override `'ignorecase'` if the search pattern contains upper case characters
vim.opt.cmdheight = 1      -- More space in the neovim command line for displaying messages
vim.opt.breakindent = true -- Enable break indent
-- vim.opt.wildignore:append({ "*/node_modules/*" }) -- Ignore when expanding wildcards, completing file or directory names

vim.opt.conceallevel = 1 -- default

-- vim.opt.formatoptions = vim.o.formatoptions:gsub("cro", "") -- Avoid comments to continue on new lines

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
-- vim.opt.foldcolumn = "1" -- '0' is not bad
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldlevelstart = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldenable = true -- Enable folding

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.laststatus = 3    -- Global statusline when on split

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false -- if true then 'listchars' will display the whitespace
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.scrolloff = 10    -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.wrap = true       -- Display long lines as just one line
vim.opt.sidescrolloff = 5 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
-- vim.opt.linebreak = true -- Wrap long lines at a character in 'breakat'
-- vim.opt.textwidth = 120 -- Maximum width of text that is being inserted vim.cmd("set fo-=1") -- Don't break lines after a one-letter word
-- vim.opt.list = false -- Hide characters on tabs and spaces
-- vim.opt.fillchars.eob = ' ' -- Empty lines at the end of a buffer as ` `
vim.opt.autoread = true  -- Sync buffers automatically
vim.opt.swapfile = false -- Disable neovim generating swapfiles and showing the error
