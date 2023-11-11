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
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("harpoon")
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
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
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
	},

	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	opts = {
	-- 		background_colour = "#000000",
	-- 	},
	-- },
}
