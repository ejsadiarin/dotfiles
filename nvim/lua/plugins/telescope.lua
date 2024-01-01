local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        -- enabled = vim.fn.executable("make") == 1,
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
        -- build = "make",
        -- enabled = vim.fn.executable("make") == 1,
        -- config = function()
        --   Util.on_load("telescope.nvim", function()
        --     require("telescope").load_extension("live-grep-args")
        --   end)
        -- end,
      },
    },
    -- pickers = {
    --   buffers = {
    --     initial_mode = "normal",
    --   },
    -- },
    -- extensions = {
    -- live_grep_args = {
    --   auto_quoting = true, -- enable/disable auto-quoting
    --   -- define mappings, e.g.
    --   mappings = { -- extend mappings
    --     i = {
    --       ["<C-k>"] = require("telescope.builtin").live_grep
    --       ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
    --     },
    --   },
    -- ... also accepts theme settings, for example:
    -- theme = "dropdown", -- use dropdown theme
    -- theme = { }, -- use own theme spec
    -- layout_config = { mirror=true }, -- mirror preview pane
    -- },
    -- },
    keys = {
      { "<leader><space>", ":silent grep ", { silent = false }, desc = "Manual Grep (rg)" },
      {
        "<leader>sg",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Live Grep (root/dynamic)",
      },
      {
        "<leader>sG",
        function()
          local dir = vim.env.HOME .. "/"
          require("telescope").extensions.live_grep_args.live_grep_args({
            search_dirs = { dir },
            -- idk if needed kekw (since it is just grepping string, not files):
            additional_args = { "--hidden" },
          })
        end,
        desc = "Live Grep from Home",
      },
      {
        "<leader>fH",
        function()
          local dir = vim.env.HOME .. "/"
          require("telescope.builtin").find_files({
            find_command = { "fd", "-tf", "-td", "-E", "node_modules", "--search-path", dir },
            prompt_prefix = "~/ ",
          })
        end,
        desc = "Find files from Home",
      },
      {
        "<leader>fd",
        function()
          local dir = vim.env.HOME .. "/dotfiles"
          require("telescope.builtin").find_files({
            find_command = { "fd", "-tf", "--hidden", "--search-path", dir },
            prompt_prefix = "~/dotfiles ",
          })
        end,
        desc = "Exquisite Dotfiles",
      },
      {
        "<leader>fC",
        function()
          local dir = vim.env.HOME .. "/.config"
          require("telescope.builtin").find_files({
            find_command = { "fd", "-tf", "-td", "--hidden", "--search-path", dir },
            prompt_prefix = "~/.configs ",
          })
        end,
        desc = "Find files on .configs",
      },
      -- { "<leader>sG", require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false }), desc = "Grep (root/dynamic)" },
      -- replaced keymaps:
      -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    },
    config = function()
      Util.on_load("telescope.nvim", function()
        local telescope = require("telescope")
        telescope.load_extension("live_grep_args")
      end)
    end,
  },
}
