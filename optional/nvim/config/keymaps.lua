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

-- Harpoon marks
-- vim.keymap.set("n", "<leader>fh", "<CMD>Telescope harpoon marks<CR>", { desc = "Find Harpoon Marks in Project" })
vim.keymap.set("n", "<leader>fh", require("harpoon.ui").toggle_quick_menu, { desc = "Find Harpoon Marks in Project" })
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Harpoon add mark" })
vim.keymap.set("n", "<c-l>", require("harpoon.ui").nav_next, {})
vim.keymap.set("n", "<c-h>", require("harpoon.ui").nav_prev, {})
vim.keymap.set(
	"n",
	"<leader>h1",
	'<CMD>lua require("harpoon.ui").nav_file(1)<CR>',
	{ desc = "Navigate to harpoon buffer 1" }
)
vim.keymap.set("n", "<leader>h2", '<CMD>lua require("harpoon.ui").nav_file(2)<CR>', { desc = "...buffer 2" })
vim.keymap.set("n", "<leader>h3", '<CMD>lua require("harpoon.ui").nav_file(3)<CR>', { desc = "...buffer 3" })
vim.keymap.set("n", "<leader>h4", '<CMD>lua require("harpoon.ui").nav_file(4)<CR>', { desc = "...buffer 4" })
vim.keymap.set("n", "<leader>h5", '<CMD>lua require("harpoon.ui").nav_file(5)<CR>', { desc = "...buffer 5" })
vim.keymap.set("n", "<leader>h6", '<CMD>lua require("harpoon.ui").nav_file(6)<CR>', { desc = "...buffer 6" })
vim.keymap.set("n", "<leader>h7", '<CMD>lua require("harpoon.ui").nav_file(7)<CR>', { desc = "...buffer 7" })
vim.keymap.set("n", "<leader>h8", '<CMD>lua require("harpoon.ui").nav_file(8)<CR>', { desc = "...buffer 8" })
vim.keymap.set("n", "<leader>h9", '<CMD>lua require("harpoon.ui").nav_file(9)<CR>', { desc = "...buffer 9" })
