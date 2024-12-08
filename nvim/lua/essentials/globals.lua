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

local _border = "rounded"

vim.diagnostic.config({
    float = { border = _border },
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = "󰌵",
        },
    },
})

-- Rounded borders for LSP hover floating window
-- TODO: add snacks.nvim win, check if have snacks.nvim first, if not then fallback to native
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = "rounded",
        -- add the title in hover float window
        -- title = "hover"
    }
)

-- Rounded borders for LSP signatureHelp floating window
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded",
    }
)
