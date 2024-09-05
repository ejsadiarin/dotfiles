-- #################
-- #    GLOBALS    #
-- #################

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.g.diagnostics_active = true
-- vim.g.markdown_recommended_style = 0 -- Disable default markdown styles (see https://www.reddit.com/r/neovim/comments/z2lhyz/comment/ixjb7je)
vim.g.autoformat = true -- format on save
