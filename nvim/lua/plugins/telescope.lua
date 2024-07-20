local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    -- enabled = function()
    --   return LazyVim.pick.want() == "telescope"
    -- end,
    -- version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
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
    --   -- {
    --   --   "nvim-telescope/telescope-fzf-native.nvim",
    --   --   build = "make",
    --   --   -- enabled = vim.fn.executable("make") == 1,
    --   --   config = function()
    --   --     Util.on_load("telescope.nvim", function()
    --   --       require("telescope").load_extension("fzf")
    --   --     end)
    --   --   end,
    --   -- },
    --   {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build = have_make and "make"
    --       or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    --     enabled = have_make or have_cmake,
    --     config = function(plugin)
    --       LazyVim.on_load("telescope.nvim", function()
    --         local ok, err = pcall(require("telescope").load_extension, "fzf")
    --         if not ok then
    --           local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
    --           if not vim.uv.fs_stat(lib) then
    --             LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
    --             require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
    --               LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
    --             end)
    --           else
    --             LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
    --           end
    --         end
    --       end)
    --     end,
    --   },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("live_grep_args")
      -- Util.on_load("telescope.nvim", function()
      -- end)
    end,
    -- pickers = {
    --   buffers = {
    --     initial_mode = "normal",
    --   },
    -- },
    -- extensions = {
    --   live_grep_args = {
    --     auto_quoting = true, -- enable/disable auto-quoting
    --     -- define mappings, e.g.
    --     mappings = { -- extend mappings
    --       i = {
    --         ["<C-k>"] = require("telescope-live_grep_args").actions.quote_prompt(),
    --         ["<C-i>"] = require("telescope-live_grep_args").actions.quote_prompt({ postfix = " --iglob " }),
    --       },
    --     },
    --     -- ... also accepts theme settings, for example:
    --     -- theme = "dropdown", -- use dropdown theme
    --     -- theme = { }, -- use own theme spec
    --     -- layout_config = { mirror=true }, -- mirror preview pane
    --   },
    -- },
    keys = {
      { "<leader><space>", false },
      { "<leader>ft", false },
      { "<leader>fT", false },
      { "<leader>,", false },
      -- somehow this works only on cwd (not dynamic)
      -- {
      --   "<leader>sg",
      --   function()
      --     require("telescope").extensions.live_grep_args.live_grep_args()
      --   end,
      --   desc = "Live Grep (root/dynamic)",
      -- },
      { "<leader>sg", Util.pick("live_grep"), desc = "Grep (dynamic)" },
      -- {
      --   "<leader>sG",
      --   function()
      --     local dir = vim.env.HOME .. "/"
      --     require("telescope").extensions.live_grep_args.live_grep_args({
      --       search_dirs = { dir },
      --       additional_args = { "--hidden" },
      --     })
      --   end,
      --   desc = "Live Grep from Home",
      -- },
      -- {
      --   "<leader>se",
      --   function()
      --     require("telescope").extensions.live_grep_args.live_grep_args()
      --   end,
      --   desc = "Live Grep Args (cwd)",
      -- },
      -- {
      --   "<leader>sN",
      --   function()
      --     local dir = vim.env.HOME .. "/vault/wizardry"
      --     require("telescope").extensions.live_grep_args.live_grep_args({
      --       search_dirs = { dir },
      --       additional_args = { "--hidden" },
      --     })
      --   end,
      --   desc = "Live Grep from Wizardry Notes",
      -- },
      -- { "<leader>ff", Util.pick.telescope("files"), desc = "Find Files (dynamic)" },
      -- { "<leader>fF", Util.pick.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      {
        "<leader>fe",
        function()
          local cwd = vim.fn.getcwd()
          require("telescope.builtin").find_files({
            find_command = {
              "fd",
              "-tf",
              "--hidden",
              "--exclude",
              ".git",
              "--exclude",
              ".obsidian",
              "--exclude",
              "node_modules",
              "--search-path",
              cwd,
            },
            prompt_prefix = "   ",
          })
        end,
        desc = "Special Find",
      },
      {
        "<leader>fH",
        function()
          local dir = vim.env.HOME .. "/"
          require("telescope.builtin").find_files({
            find_command = {
              "fd",
              "-tf",
              "--hidden",
              "--exclude",
              "node_modules",
              "--exclude",
              ".git",
              "--exclude",
              ".quokka",
              "--exclude",
              ".cargo",
              "--exclude",
              ".vscode",
              "--search-path",
              dir,
            },
            prompt_prefix = "   ~ | ",
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
            prompt_prefix = "   dotfiles | ",
          })
        end,
        desc = "Exquisite Dotfiles",
      },
      {
        "<leader>fc",
        function()
          local dir = vim.env.HOME .. "/.config"
          require("telescope.builtin").find_files({
            find_command = { "fd", "-tf", "--hidden", "--search-path", dir },
            prompt_prefix = "   .config | ",
          })
        end,
        desc = "Find files on .config",
      },
      {
        "<leader>fm",
        function()
          local dir = vim.env.HOME .. "/main"
          require("telescope.builtin").find_files({
            find_command = {
              "fd",
              "-tf",
              "--hidden",
              "--exclude",
              "node_modules",
              "--exclude",
              ".git",
              "--search-path",
              dir,
            },
            prompt_prefix = "   main | ",
          })
        end,
        desc = "Find files on main",
      },
      {
        "<leader>fw",
        function()
          local dir = vim.env.HOME .. "/vault/wizardry"
          require("telescope.builtin").find_files({
            find_command = {
              "fd",
              "-tf",
              "--hidden",
              "--exclude",
              "node_modules",
              "--exclude",
              ".git",
              "--search-path",
              dir,
            },
            prompt_prefix = "   wizardry | ",
          })
        end,
        desc = "Find wizardry notes",
      },
      {
        "<leader>gb",
        "<CMD>Telescope git_branches<CR>",
        desc = "branches",
      },
      -- replaced keymaps:
      -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
      -- { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    },
  },
}
