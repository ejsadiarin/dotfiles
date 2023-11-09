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
				inc_rename = false,
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
	-- extend noice functionality
	--  {
	-- 	"folke/noice.nvim",
	-- 	opts = function(_, opts)
	-- 		table.insert(opts.routes, {
	-- 			filter = {
	-- 				event = "notify",
	-- 				find = "No information available",
	-- 			},
	-- 			opts = { skip = true },
	-- 		})
	-- 	end,
	-- 	presets = { inc_rename = true },
	-- },

	{
		"norcalli/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"html",
				"css",
				"javascript",
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"lua",
			},
			user_default_options = {
				mode = "background",
				tailwind = false, -- Enable tailwind colors
			},
		},
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
		-- event = "InsertEnter",
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
		{
			"echasnovski/mini.surround",
			opts = {
				mappings = {
					add = "sa",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
				},
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			enable_close_on_slash = false,
		},
	},
	{
		"Issafalcon/lsp-overloads.nvim",
		-- next_signature = "<C-j>"
		-- previous_signature = "<C-k>"
		-- next_parameter = "<C-l>"
		-- previous_parameter = "<C-h>"
		-- close_signature = "<A-s>"
	},

	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	opts = {
	-- 		background_colour = "#000000",
	-- 	},
	-- },
}
