-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

local util = require("lazyvim.util")

-- remap normal mode to "kj" when insert mode
vim.keymap.set("i", "kj", "<ESC>", { silent = true })
vim.keymap.set("n", "<TAB>", "<C-W>w")
vim.keymap.set("n", "<S-TAB>", "<C-W>W")

-- unpolluted paste (access paste without "dd" buffer pollute)
vim.keymap.set("n", "<leader>p", '"0p', { desc = "Unpolluted Paste" })

-- center cursor when scrolling up and down via keymaps
vim.keymap.set("n", "<C-U>", "<C-U>zz")
vim.keymap.set("n", "<C-D>", "<C-D>zz")

-- better renaming functionality
vim.keymap.set({ "n", "v" }, "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- colorizer keymap
vim.keymap.set("n", "<leader>cc", "<CMD>ColorizerAttachToBuffer<CR>")

-- Save without formatting
vim.keymap.set("n", "<leader>cs", ":noautocmd w<CR>", { desc = "Save without formatting" })

-- Terminal with border
local lazyterm = function()
	util.terminal(nil, { cwd = util.root(), border = "rounded" })
end
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
