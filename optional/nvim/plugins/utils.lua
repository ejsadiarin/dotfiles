return {
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},

	-- {
	--   "folke/noice.nvim",
	--   opts = function(_, opts)
	--     table.insert(opts.routes, {
	--       filter = {
	--         event = "notify",
	--         find = "No information available",
	--       },
	--       opts = { skip = true },
	--     })
	--   end,
	--   presets = { inc_rename = true },
	--   cmdline = { enabled = false },
	--   messages = { enabled = false },
	-- },
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				enabled = false,
			},
			messages = {
				enabled = false,
			},
			presets = {
				inc_rename = true,
			},
		},
		config = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
	-- highlight css colors
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			ft = { "css" },
			config = true,
			lazy = true,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
}
