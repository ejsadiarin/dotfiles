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

-- Rounded borders for LSP hover floating window
local _border = "rounded"

vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
    config = config or {}
    config.border = _border
    config.focus_id = ctx.method
    if not (result and result.contents) then
        return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.split(table.concat(markdown_lines, '\n'), '\n', { trimempty = true })
    -- markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

    if vim.tbl_isempty(markdown_lines) then
        return
    end
    return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    }
)

vim.diagnostic.config {
    float = { border = _border }
}
