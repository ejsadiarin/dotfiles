return {
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},

	-- extend noice functionality
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
		end,
		presets = { inc_rename = true },
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
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
		},
	},
}
