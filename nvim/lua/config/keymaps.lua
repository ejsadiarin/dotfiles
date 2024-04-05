-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- #######################################
-- #     disabled general keymaps        #
-- #######################################
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
-- local map = vim.keymap.set
-- map("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader>t]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader>t[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- #######################################

-- #######################################
-- #         custom keymaps              #
-- #######################################
local util = require("lazyvim.util")

-- remap normal mode to "kj" when insert mode
vim.keymap.set("i", "kj", "<ESC>", { silent = true })

-- use Tab to switch cycle window
vim.keymap.set("n", "<TAB>", "<C-W>w")
vim.keymap.set("n", "<S-TAB>", "<C-W>W")

-- unpolluted paste (paste from yank register)
vim.keymap.set({ "n", "x" }, "<leader>p", '"0p', { desc = "Unpolluted Paste" })

-- changes cwd to head of current buffer (useful for grepping and finding files)
vim.keymap.set("n", "<leader>cw", function()
  -- Define the change_cwd_head_of_buffer function
  _G.utils = _G.utils or {}
  function _G.utils.change_cwd_to_head_of_buffer()
    local bufname = vim.fn.expand("%:p:h")
    vim.cmd(string.format('cd %s | echom "CWD changed to: %s"', vim.fn.fnameescape(bufname), bufname))
  end
  _G.utils.change_cwd_to_head_of_buffer()
end, { noremap = true, desc = "Change cwd to head of current buffer", silent = false })

-- center cursor when scrolling up and down via keymaps
vim.keymap.set("n", "<C-U>", "<C-U>zz")
vim.keymap.set("n", "<C-D>", "<C-D>zz")

-- move lines
vim.keymap.set("n", "<C-n>", "<CMD>m .+1<CR>==", { desc = "Move line dow(n)" })
vim.keymap.set("n", "<C-p>", "<CMD>m .-2<CR>==", { desc = "Move line u(p)" })
vim.keymap.set("i", "<C-n>", "<ESC><CMD>m .+1<CR>==gi", { desc = "Move line dow(n)" })
vim.keymap.set("i", "<C-p>", "<ESC><CMD>m .-2<CR>==gi", { desc = "Move line u(p)" })
vim.keymap.set("v", "<C-n>", ":m '>+1<CR>gv=gv", { desc = "Move line dow(n)" })
vim.keymap.set("v", "<C-p>", ":m '<-2<CR>gv=gv", { desc = "Move line u(p)" })

-- colorizer keymap
vim.keymap.set("n", "<leader>ce", "<CMD>ColorizerToggle<CR>")

-- Save without formatting
vim.keymap.set("n", "<leader>cS", ":noautocmd w<CR>", { desc = "Save without formatting" })

-- Vertical and Horizontal Splits
vim.keymap.set("n", "<leader>wh", "<C-W>s", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Vertical Split" })

-- Switch to other buffer like ctrl+tab
-- vim.keymap.set("n", "<leader><space>", "<CMD>e #<CR>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader><tab>", "<CMD>e #<CR>", { desc = "Switch buffer" })

-- Terminal with border
local lazyterm = function()
  util.terminal(nil, { cwd = util.root(), border = "rounded" })
end
vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })

-- Multiple cursors/ visual-multi (https://github.com/mg979/vim-visual-multi/wiki/Mappings)
vim.keymap.set("n", "<leader>vm", "<Plug>(VM-Find-Under)", { desc = "Start Visual Multi" })

-- vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)", { desc = "VM mode Cursor Up" })
-- vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)", { desc = "VM mode Cursor Down" })
vim.keymap.set("n", "<M-C-k>", "<Plug>(VM-Add-Cursor-Up)", { desc = "VM mode Cursor Up" })
vim.keymap.set("n", "<M-C-j>", "<Plug>(VM-Add-Cursor-Down)", { desc = "VM mode Cursor Down" })

vim.keymap.set("n", "<C-RightMouse>", "<Plug>(VM-Mouse-Word)", { desc = "Multi line cursor" })
vim.keymap.set("n", "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)", { desc = "Multi line cursor" })
vim.keymap.set("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)", { desc = "Multi line cursor" })
-- visual multi specific options
-- vim.g.VM_maps = {}
-- vim.g.VM_maps['Find Under']                  = '<C-n>'
-- vim.g.VM_maps['Find Subword Under']          = '<C-n>'
-- vim.g.VM_maps["Select All"]                  = '\\A'
-- vim.g.VM_maps["Start Regex Search"]          = '\\/'
-- vim.g.VM_maps["Add Cursor Down"]             = '<C-Down>'
-- vim.g.VM_maps["Add Cursor Up"]               = '<C-Up>'
-- vim.g.VM_maps["Add Cursor At Pos"]           = '\\\'

-- vim.g.VM_maps["Visual Regex"]                = '\\/'
-- vim.g.VM_maps["Visual All"]                  = '\\A'
-- vim.g.VM_maps["Visual Add"]                  = '\\a'
-- vim.g.VM_maps["Visual Find"]                 = '\\f'
-- vim.g.VM_maps["Visual Cursors"]              = '\\c'

-- vim.g.VM_maps["Switch Mode"]                 = '<Tab>'
-- vim.g.VM_maps["Find Next"]                   = ']'
-- vim.g.VM_maps["Find Prev"]                   = '['
-- vim.g.VM_maps["Goto Next"]                   = '}'
-- vim.g.VM_maps["Goto Prev"]                   = '{'
-- vim.g.VM_maps["Seek Next"]                   = '<C-f>'
-- vim.g.VM_maps["Seek Prev"]                   = '<C-b>'
-- vim.g.VM_maps["Skip Region"]                 = 'q'
-- vim.g.VM_maps["Remove Region"]               = 'Q'
-- vim.g.VM_maps["Invert Direction"]            = 'o'
-- vim.g.VM_maps["Find Operator"]               = "m"
-- vim.g.VM_maps["Surround"]                    = 'S'
-- vim.g.VM_maps["Replace Pattern"]             = 'R'

-- vim.g.VM_maps["Tools Menu"]                  = '\\`'
-- vim.g.VM_maps["Show Registers"]              = '\\"'
-- vim.g.VM_maps["Case Setting"]                = '\\c'
-- vim.g.VM_maps["Toggle Whole Word"]           = '\\w'
-- vim.g.VM_maps["Transpose"]                   = '\\t'
-- vim.g.VM_maps["Align"]                       = '\\a'
-- vim.g.VM_maps["Duplicate"]                   = '\\d'
-- vim.g.VM_maps["Rewrite Last Search"]         = '\\r'
-- vim.g.VM_maps["Merge Regions"]               = '\\m'
-- vim.g.VM_maps["Split Regions"]               = '\\s'
-- vim.g.VM_maps["Remove Last Region"]          = '\\q'
-- vim.g.VM_maps["Visual Subtract"]             = '\\s'
-- vim.g.VM_maps["Case Conversion Menu"]        = '\\C'
-- vim.g.VM_maps["Search Menu"]                 = '\\S'

-- vim.g.VM_maps["Run Normal"]                  = '\\z'
-- vim.g.VM_maps["Run Last Normal"]             = '\\Z'
-- vim.g.VM_maps["Run Visual"]                  = '\\v'
-- vim.g.VM_maps["Run Last Visual"]             = '\\V'
-- vim.g.VM_maps["Run Ex"]                      = '\\x'
-- vim.g.VM_maps["Run Last Ex"]                 = '\\X'
-- vim.g.VM_maps["Run Macro"]                   = '\\@'
-- vim.g.VM_maps["Align Char"]                  = '\\<'
-- vim.g.VM_maps["Align Regex"]                 = '\\>'
-- vim.g.VM_maps["Numbers"]                     = '\\n'
-- vim.g.VM_maps["Numbers Append"]              = '\\N'
-- vim.g.VM_maps["Zero Numbers"]                = '\\0n'
-- vim.g.VM_maps["Zero Numbers Append"]         = '\\0N'
-- vim.g.VM_maps["Shrink"]                      = "\\-"
-- vim.g.VM_maps["Enlarge"]                     = "\\+"

-- vim.g.VM_maps["Toggle Block"]                = '\\<BS>'
-- let g:VM_maps["Toggle Single Region"]        = '\\<CR>'
-- let g:VM_maps["Toggle Multiline"]            = '\\M'
