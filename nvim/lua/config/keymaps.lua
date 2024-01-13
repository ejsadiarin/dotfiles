-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local util = require("lazyvim.util")

-- remap normal mode to "kj" when insert mode
vim.keymap.set("i", "kj", "<ESC>", { silent = true })

-- ####### Disabled General Keymaps ####### --
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>-")
-- ######################################## --

-- use Tab to switch cycle window
vim.keymap.set("n", "<TAB>", "<C-W>w")
vim.keymap.set("n", "<S-TAB>", "<C-W>W")

-- unpolluted paste (access paste without "dd" buffer pollute)
vim.keymap.set("n", "<leader>p", '"0p', { desc = "Unpolluted Paste" })

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

-- colorizer keymap
vim.keymap.set("n", "<leader>cc", "<CMD>ColorizerToggle<CR>")

-- Save without formatting
vim.keymap.set("n", "<leader>cs", ":noautocmd w<CR>", { desc = "Save without formatting" })

-- Vertical and Horizontal Splits
vim.keymap.set("n", "<leader>wh", "<C-W>s", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Vertical Split" })

-- Switch to other buffer like ctrl+tab
vim.keymap.set("n", "<leader><space>", "<cmd>e #<cr>", { desc = "Switch buffer" })

-- Terminal with border
local lazyterm = function()
  util.terminal(nil, { cwd = util.root(), border = "rounded" })
end
vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })

-- ############################ HARPOON START ############################ --
-- Harpoon
local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end, { desc = "Harpoon add mark" })

vim.keymap.set("n", "<leader>fh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Find Harpoon Marks" })

vim.keymap.set("n", "<S-p>", function()
  harpoon:list():prev()
end)

vim.keymap.set("n", "<S-n>", function()
  harpoon:list():next()
end)

-- simulate vim marks for harpoon
vim.keymap.set("n", "<leader>1", function()
  if harpoon:list():select(1) == nil then
    harpoon:list():append()
  else
    harpoon:list():select(1)
  end
end, { desc = "working main buffer (harpoon) " })
vim.keymap.set("n", "<leader>2", function()
  if harpoon:list():select(2) == nil then
    harpoon:list():append()
  else
    harpoon:list():select(2)
  end
end, { desc = "other main buffer (harpoon)" })

vim.keymap.set("n", "<leader>3", function()
  if harpoon:list():select(3) == nil then
    harpoon:list():append()
  else
    harpoon:list():select(3)
  end
end, { desc = "interesting buffer (harpoon)" })

vim.keymap.set("n", "<leader>4", function()
  if harpoon:list():select(4) == nil then
    harpoon:list():append()
  else
    harpoon:list():select(4)
  end
end, { desc = "keep buffer (harpoon)" })

vim.keymap.set("n", "<leader>5", function()
  if harpoon:list():select(5) == nil then
    harpoon:list():append()
  else
    harpoon:list():select(5)
  end
end, { desc = "disposable buffer (harpoon)" })
-- use telescope for Harpoon UI (cannot edit like a buffer tho)
-- vim.keymap.set("n", "<leader>fh", function()
--   local conf = require("telescope.config").values
--   local function toggle_telescope(harpoon_files)
--     local file_paths = {}
--     for _, item in ipairs(harpoon_files.items) do
--       table.insert(file_paths, item.value)
--     end
--
--     require("telescope.pickers")
--       .new({}, {
--         prompt_title = "Harpoon",
--         finder = require("telescope.finders").new_table({
--           results = file_paths,
--         }),
--         previewer = conf.file_previewer({}),
--         sorter = conf.generic_sorter({}),
--       })
--       :find()
--   end
--   toggle_telescope(harpoon:list())
--   -- harpoon.ui:toggle_telescope(harpoon:list())
-- end, { desc = "Find Harpoon Marks in Project" })
-- ############################ HARPOON END ############################ --

-- Tmux Navigation
vim.keymap.set("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { desc = "Tmux Navigate Left" })
vim.keymap.set("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { desc = "Tmux Navigate Down" })
vim.keymap.set("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { desc = "Tmux Navigate Up" })
vim.keymap.set("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { desc = "Tmux Navigate Right" })

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
