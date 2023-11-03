return {
	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},

	-- {
	--   "sainnhe/gruvbox-material",
	--   name = "gruvbox-material",
	--   lazy = false,
	--   priority = 1000,
	--   config = function()
	--     vim.g.gruvbox_material_better_performance = 1
	--     -- Fonts
	--     vim.g.gruvbox_material_disable_italic_comment = 1
	--     vim.g.gruvbox_material_enable_italic = 0
	--     vim.g.gruvbox_material_enable_bold = 0
	--     vim.g.gruvbox_material_transparent_background = 1
	--     -- Themes
	--     vim.g.gruvbox_material_foreground = "mix"
	--     vim.g.gruvbox_material_background = "hard"
	--     vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
	--     vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
	--
	--     vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
	--   end,
	-- },
	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}
