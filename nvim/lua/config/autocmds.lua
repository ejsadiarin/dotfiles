-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1d2021]])
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=#fbf1c7 guibg=#1d2021]])

-- ############################################# COLORSCHEME HIGHLIGHT GROUPS PALETTE OVERRIDE: #############################################
-- ref: https://github.com/LazyVim/LazyVim/discussions/2278
-- can put this in property `config` as: config = function() end
-- local theme = require("catppuccin.palettes.macchiato")
-- local windowBg = theme.crust
--
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   group = vim.api.nvim_create_augroup("Catppuccin_highlights", { clear = true }),
--   desc = "Change Catppuccin highlights",
--   callback = function()
--     vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", {
--       fg = windowBg,
--       bg = windowBg,
--     })
--
--     vim.api.nvim_set_hl(0, "NeoTreeTitleBar", {
--       fg = windowBg,
--       bg = windowBg,
--     })
--
--     vim.api.nvim_set_hl(0, "NeoTreeNormal", {
--       fg = theme.text,
--       bg = windowBg,
--     })
--   end,
-- })
-- #######################################################################################################################################

-- ########################################################### IP HIGHLIGHT ##############################################################
-- vim.api.nvim_set_hl(0, "IP_highlight", { fg = "red", bg = "None" })
-- vim.fn.matchadd("IP_highlight", "\\(\\d\\{1,3}\\.\\)\\{3}\\d\\{1,3}")  -- naive IPv4 regex
-- #######################################################################################################################################

-- Enter normal mode when leaving telescope
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

-- Disable autoformat for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- -- See all fidget notifications for history
-- vim.api.nvim_create_autocmd({ "LspProgress" }, {
--   callback = function(context)
--     vim.notify(vim.inspect(context))
--     -- or vim.print(context) if you want something less invasive
--   end,
-- })
--
vim.api.nvim_exec(
  [[
  augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
  augroup END
]],
  false
)

-- :h hi
-- https://stackoverflow.com/questions/7103173/vim-how-to-change-the-highlight-color-for-search-hits-and-quickfix-selection
-- for GUI:
--hi Search guibg=peru guifg=wheat
-- for terminals:
--hi Search cterm=NONE ctermfg=grey ctermbg=blue
-- vim.api.nvim_set_hl(0, "FidgetTitle", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "FidgetTask", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "transparentBG", { bg = "NONE", fg = "LightGray" })

-- prints diagnostics on message area, has problems if diagnostic has too many messages
-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--   opts = opts or { ["lnum"] = line_nr }
--
--   local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--   if vim.tbl_isempty(line_diagnostics) then
--     return
--   end
--
--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     print(diagnostic_message)
--     if i ~= #line_diagnostics then
--       diagnostic_message = diagnostic_message .. "\n"
--     end
--   end
--   vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
-- end
--
-- vim.cmd([[ autocmd! CursorHold * lua PrintDiagnostics() ]])

-- -- LSP settings (for overriding per client)
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
-- }

-- Do not forget to use the on_attach function
-- require("lspconfig").myserver.setup({ handlers = handlers })

-- -- To instead override globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

-- require("lspconfig").myservertwo.setup({})

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- TODO: search for nvim-lspconfig winhighlight property for border when hovered
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  -- disable notif: "No information available"
  silent = true,
  -- does not work:
  winhighlight = "Normal:FloatNormal,FloatBorder:FloatNormal,CursorLine:TelescopeSelection,Search:None",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  winhighlight = "Normal:FloatNormal,FloatBorder:FloatNormal,CursorLine:TelescopeSelection,Search:None",
})

-- ref: https://gist.github.com/timmyha/b611a8e34a4f8d13cb52ae755dbfef2c
-- reddit ref: https://gist.github.com/timmyha/b611a8e34a4f8d13cb52ae755dbfef2c
vim.diagnostic.config({
  virtual_text = true,
  float = {
    header = false,
    border = "single",
    focusable = true,
  },
  severity_sort = true,
})

vim.lsp.protocol.make_client_capabilities().textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
