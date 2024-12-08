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
            -- DiagnosticSignError = { text = " ", texthl = "DiagnosticSignError" },
            -- DiagnosticSignWarn = { text = " ", texthl = "DiagnosticSignWarn" },
            -- DiagnosticSignInfo = { text = " ", texthl = "DiagnosticSignInfo" },
            -- DiagnosticSignHint = { text = "󰌵", texthl = "DiagnosticSignHint" },
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
        -- Use a sharp border with `FloatBorder` highlights
        border = "rounded",
        -- add the title in hover float window
        -- title = "hover"
    }
)


-- vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
--     config = config or {}
--     config.border = _border
--     config.focus_id = ctx.method
--     if not (result and result.contents) then
--         return
--     end
--     local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--     markdown_lines = vim.split(table.concat(markdown_lines, '\n'), '\n', { trimempty = true })
--     -- markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--
--     if vim.tbl_isempty(markdown_lines) then
--         return
--     end
--     return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
-- end

-- Update hover handler
-- vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx)
--     if err or not (result and result.contents) then
--         return
--     end
--
--     local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--     markdown_lines = vim.split(table.concat(markdown_lines, '\n'), '\n', { trimempty = true })
--
--     if vim.tbl_isempty(markdown_lines) then
--         return
--     end
--
--     vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', { border = _border, focus_id = ctx.method })
-- end
--
-- -- Update signatureHelp handler
-- vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx)
--     if err or not result or not result.signatures or vim.tbl_isempty(result.signatures) then
--         return
--     end
--
--     local lines = vim.lsp.util.convert_signature_help_to_markdown_lines(result)
--
--     vim.lsp.util.open_floating_preview(lines, "markdown", { border = _border })
-- end
