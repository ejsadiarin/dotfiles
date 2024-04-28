return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  optional = true,
  opts = function(_, opts)
    opts.defaults["<leader>v"] = { name = "+visual-multi" }
    opts.defaults["<leader>o"] = { name = "+obsidian" }
    opts.defaults["<leader>,"] = { name = "+specials" }
    opts.defaults["<leader><tab>"] = nil -- HACK: adding this makes the <leader><tab> work (see in keymaps.lua) for some reason, related to this? https://github.com/folke/which-key.nvim/blob/4433e5ec9a507e5097571ed55c02ea9658fb268a/lua/which-key/keys.lua#L6
  end,
  -- opts = {
  --   defaults = {
  --     -- ["<leader>h"] = { name = "+harpoon" },
  --     ["<leader>v"] = { name = "+visual-multi" },
  --     ["<leader><tab>"] = nil,
  --     ["<leader><1>"] = "which_key_ignore",
  --     ["<leader><2>"] = "which_key_ignore",
  --     ["<leader><3>"] = "which_key_ignore",
  --     ["<leader><4>"] = "which_key_ignore",
  --     ["<leader><5>"] = "which_key_ignore",
  --     ["<leader><6>"] = "which_key_ignore",
  --     ["<leader><7>"] = "which_key_ignore",
  --     ["<leader><8>"] = "which_key_ignore",
  --     ["<leader><9>"] = "which_key_ignore",
  --   },
  --   ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  -- },
}
