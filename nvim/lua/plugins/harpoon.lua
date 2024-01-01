return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    global_settings = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = false,

      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,

      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = false,

      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,

      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { "harpoon" },

      -- set marks specific to each git branch inside git repository
      mark_branch = true,

      -- enable tabline with harpoon marks
      tabline = true,
      tabline_prefix = "   ",
      tabline_suffix = "   ",
    },
  },
  config = true,
  -- keys = {
  --   {
  --     "n",
  --     "<leader>fh",
  --     function()
  --       local harpoon = require("harpoon")
  --       harpoon:setup({})
  --       local conf = require("telescope.config").values
  --       local function toggle_telescope(harpoon_files)
  --         local file_paths = {}
  --         for _, item in ipairs(harpoon_files.items) do
  --           table.insert(file_paths, item.value)
  --         end
  --
  --         require("telescope.pickers")
  --           .new({}, {
  --             prompt_title = "Harpoon",
  --             finder = require("telescope.finders").new_table({
  --               results = file_paths,
  --             }),
  --             previewer = conf.file_previewer({}),
  --             sorter = conf.generic_sorter({}),
  --           })
  --           :find()
  --       end
  --       toggle_telescope(harpoon:list())
  --     end,
  --     { desc = "Find Harpoon Marks" },
  --   },
}
-- },

-- Harpoon marks
-- vim.keymap.set("n", "<leader>fh", "<CMD>Telescope harpoon marks<CR>", { desc = "Find Harpoon Marks in Project" })
-- vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end, { desc = "Find Harpoon Marks in Project" })
-- vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Harpoon add mark" })
-- vim.keymap.set("n", "<c-n>", require("harpoon.ui").nav_next, {})
-- vim.keymap.set("n", "<c-p>", require("harpoon.ui").nav_prev, {})
-- vim.keymap.set(
--   "n",
--   "<leader>h1",
--   '<CMD>lua require("harpoon.ui").nav_file(1)<CR>',
--   { desc = "Navigate to harpoon buffer 1" }
-- )
-- vim.keymap.set("n", "<leader>h2", '<CMD>lua require("harpoon.ui").nav_file(2)<CR>', { desc = "...buffer 2" })
-- vim.keymap.set("n", "<leader>h3", '<CMD>lua require("harpoon.ui").nav_file(3)<CR>', { desc = "...buffer 3" })
-- vim.keymap.set("n", "<leader>h4", '<CMD>lua require("harpoon.ui").nav_file(4)<CR>', { desc = "...buffer 4" })
-- vim.keymap.set("n", "<leader>h5", '<CMD>lua require("harpoon.ui").nav_file(5)<CR>', { desc = "...buffer 5" })
-- vim.keymap.set("n", "<leader>h6", '<CMD>lua require("harpoon.ui").nav_file(6)<CR>', { desc = "...buffer 6" })
-- vim.keymap.set("n", "<leader>h7", '<CMD>lua require("harpoon.ui").nav_file(7)<CR>', { desc = "...buffer 7" })
-- vim.keymap.set("n", "<leader>h8", '<CMD>lua require("harpoon.ui").nav_file(8)<CR>', { desc = "...buffer 8" })
-- vim.keymap.set("n", "<leader>h9", '<CMD>lua require("harpoon.ui").nav_file(9)<CR>', { desc = "...buffer 9" })
