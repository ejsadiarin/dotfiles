return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Journal",
        path = "~/vault/Personal/Journal",
      },
      {
        name = "Wizardry",
        path = "~/vault/wizardry",
      },
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "~/vault/Personal/Journal",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    new_notes_location = "Journal",

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },

    -- -- Optional, configure additional syntax highlighting / extmarks.
    -- -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    -- ui = {
    --   enable = true, -- set to false to disable all additional syntax features
    --   update_debounce = 200, -- update delay after a text change (in milliseconds)
    --   -- Define how various check-boxes are displayed
    --   checkboxes = {
    --     -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
    --     [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
    --     ["x"] = { char = "", hl_group = "ObsidianDone" },
    --     [">"] = { char = "", hl_group = "ObsidianRightArrow" },
    --     ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
    --     -- Replace the above with this if you don't have a patched font:
    --     -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
    --     -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
    --
    --     -- You can also add more custom ones...
    --   },
    --   -- Use bullet marks for non-checkbox lists.
    --   bullets = { char = "•", hl_group = "ObsidianBullet" },
    --   external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    --   -- Replace the above with this if you don't have a patched font:
    --   -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    --   reference_text = { hl_group = "ObsidianRefText" },
    --   highlight_text = { hl_group = "ObsidianHighlightText" },
    --   tags = { hl_group = "ObsidianTag" },
    --   block_ids = { hl_group = "ObsidianBlockID" },
    --   hl_groups = {
    --     -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
    --     ObsidianTodo = { bold = true, fg = "#f78c6c" },
    --     ObsidianDone = { bold = true, fg = "#89ddff" },
    --     ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
    --     ObsidianTilde = { bold = true, fg = "#ff5370" },
    --     ObsidianBullet = { bold = true, fg = "#89ddff" },
    --     ObsidianRefText = { underline = true, fg = "#c792ea" },
    --     ObsidianExtLinkIcon = { fg = "#c792ea" },
    --     ObsidianTag = { italic = true, fg = "#89ddff" },
    --     ObsidianBlockID = { italic = true, fg = "#89ddff" },
    --     ObsidianHighlightText = { bg = "#75662e" },
    --   },
    -- },
    --
    -- -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "assets", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
  keys = {
    {
      "<leader>fo",
      "<CMD>ObsidianQuickSwitch<CR>",
      desc = "Obsidian Quick Switch",
    },
    {
      "<leader>of",
      "<CMD>ObsidianQuickSwitch<CR>",
      desc = "Obsidian Quick Switch",
    },
    {
      "<leader>oe",
      "<CMD>ObsidianOpen<CR>",
      desc = "Open Current File in Obsidian",
    },
    {
      "<leader>oj",
      "<CMD>Obsidian<CR>",
      desc = "Journal",
    },
    {
      "<leader>os",
      "<CMD>ObsidianSearch<CR>",
      desc = "Search/Grep Vault",
    },
    {
      "<leader>ot",
      "<CMD>ObsidianTags<CR>",
      desc = "Find Files by Tags",
    },
    {
      "<leader>on",
      "<CMD>ObsidianNew<CR>",
      desc = "New Note",
    },
    {
      "<leader>ol",
      "<CMD>ObsidianLinks<CR>",
      desc = "See all links in current note/buffer",
    },
  },
}
