-- Gruvbox.palette = {
--   dark0_hard = "#1d2021",
--   dark0 = "#282828",
--   dark0_soft = "#32302f",
--   dark1 = "#3c3836",
--   dark2 = "#504945",
--   dark3 = "#665c54",
--   dark4 = "#7c6f64",
--   light0_hard = "#f9f5d7",
--   light0 = "#fbf1c7",
--   light0_soft = "#f2e5bc",
--   light1 = "#ebdbb2",
--   light2 = "#d5c4a1",
--   light3 = "#bdae93",
--   light4 = "#a89984",
--   bright_red = "#fb4934",
--   bright_green = "#b8bb26",
--   bright_yellow = "#fabd2f",
--   bright_blue = "#83a598",
--   bright_purple = "#d3869b",
--   bright_aqua = "#8ec07c",
--   bright_orange = "#fe8019",
--   neutral_red = "#cc241d",
--   neutral_green = "#98971a",
--   neutral_yellow = "#d79921",
--   neutral_blue = "#458588",
--   neutral_purple = "#b16286",
--   neutral_aqua = "#689d6a",
--   neutral_orange = "#d65d0e",
--   faded_red = "#9d0006",
--   faded_green = "#79740e",
--   faded_yellow = "#b57614",
--   faded_blue = "#076678",
--   faded_purple = "#8f3f71",
--   faded_aqua = "#427b58",
--   faded_orange = "#af3a03",
--   dark_red_hard = "#792329",
--   dark_red = "#722529",
--   dark_red_soft = "#7b2c2f",
--   light_red_hard = "#fc9690",
--   light_red = "#fc9487",
--   light_red_soft = "#f78b7f",
--   dark_green_hard = "#5a633a",
--   dark_green = "#62693e",
--   dark_green_soft = "#686d43",
--   light_green_hard = "#d3d6a5",
--   light_green = "#d5d39b",
--   light_green_soft = "#cecb94",
--   dark_aqua_hard = "#3e4934",
--   dark_aqua = "#49503b",
--   dark_aqua_soft = "#525742",
--   light_aqua_hard = "#e6e9c1",
--   light_aqua = "#e8e5b5",
--   light_aqua_soft = "#e1dbac",
--   gray = "#928374",
-- }
-- bg0 = p.dark0,
-- bg1 = p.dark1,
-- bg2 = p.dark2,
-- bg3 = p.dark3,
-- bg4 = p.dark4,
-- fg0 = p.light0,
-- fg1 = p.light1,
-- fg2 = p.light2,
-- fg3 = p.light3,
-- fg4 = p.light4,
-- red = p.bright_red,
-- green = p.bright_green,
-- yellow = p.bright_yellow,
-- blue = p.bright_blue,
-- purple = p.bright_purple,
-- aqua = p.bright_aqua,
-- orange = p.bright_orange,
-- neutral_red = p.neutral_red,
-- neutral_green = p.neutral_green,
-- neutral_yellow = p.neutral_yellow,
-- neutral_blue = p.neutral_blue,
-- neutral_purple = p.neutral_purple,
-- neutral_aqua = p.neutral_aqua,
-- dark_red = p.dark_red,
-- dark_green = p.dark_green,
-- dark_aqua = p.dark_aqua,
-- gray = p.gray,

return {
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
				strings = false,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			-- hls_highlight = "red",
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			contrast_dark = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {
				-- dark palette
				dark0_hard = "#1d2021", -- bg0_h
				dark0 = "#282828", -- bg0
				dark1 = "#3c3836", -- bg1
				dark2 = "#504945", -- bg2
				dark3 = "#665c54", -- bg3
				dark4 = "#7c6f64", -- bg4
				light0_hard = "#f9f5d7", -- fg0_h
				light0 = "#fbf1c7", -- fg0
				light1 = "#ebdbb2", -- fg1
				light2 = "#d5c4a1", -- fg2
				light3 = "#bdae93", -- fg3
				light4 = "#a89984", -- fg4
				bright_red = "#fb4934", -- red
				bright_green = "#b8bb26", -- green
				bright_yellow = "#fabd2f", -- yellow
				bright_blue = "#83a598", -- blue
				bright_purple = "#d3869b", -- purple
				bright_aqua = "#8ec07c", -- aqua
				bright_orange = "#fe8019", -- orange
				dark_red_hard = "#792329", -- dark_red_hard
				dark_green_hard = "#5a633a", -- dark_green_hard
				dark_aqua_hard = "#3e4934", -- dark_aqua_hard
				gray = "#4E4944", -- gray

				-- not included in dark palette?
				neutral_red = "#cc241d", -- neutral_red
				neutral_green = "#98971a", -- neutral_green
				neutral_yellow = "#d79921", -- neutral_yellow
				neutral_blue = "#458588", -- neutral_blue
				neutral_purple = "#b16286", -- neutral_purple
				neutral_aqua = "#689d6a", -- neutral_aqua
				neutral_orange = "#d65d0e", -- neutral_orange
				faded_red = "#9d0006", -- faded_red
				faded_green = "#79740e", -- faded_green
				faded_yellow = "#b57614", -- faded_yellow
				faded_blue = "#076678", -- faded_blue
				faded_purple = "#8f3f71", -- faded_purple
				faded_aqua = "#427b58", -- faded_aqua
				faded_orange = "#af3a03", -- faded_orange
			},
			overrides = {
				-- ref: https://github.com/ellisonleao/gruvbox.nvim/blob/477c62493c82684ed510c4f70eaf83802e398898/lua/gruvbox.lua#L288
				["@lsp.type.method"] = { fg = "#8ec07c" },
				["@lsp.type.function"] = { fg = "#8ec07c" },
				["@comment"] = { fg = "gray" },
				["@tag"] = { fg = "#8ec07c" },
				["@tag.delimiter"] = { fg = "#83a598" },
				["@tag.attribute"] = { fg = "#fabd2f" },
				["@method"] = { fg = "#8ec07c" },
				["@symbol"] = { fg = "#d3869b" },
				["@operator"] = { fg = "#8ec07c" },
				["@field"] = { fg = "#f2cfcf" },
				["@property"] = { fg = "#f2cfcf" },
				["@variable"] = { fg = "#f9f5d7" },
				["@function.builtin"] = { fg = "#f2cfcf" },
				["@function.macro"] = { fg = "#fb4934" },
				["@punctuation.delimiter"] = { fg = "#d3869b" },
				["@punctuation.bracket"] = { fg = "#fe8019" },
				["@punctuation.special"] = { fg = "#fb4934" },
				["@type"] = { fg = "#d3869b" },
				["@type.builtin"] = { fg = "#d3869b" },
				["@type.definition"] = { fg = "#fabd2f" },
				["@type.qualifier"] = { fg = "#fabd2f" },
				["@constant"] = { fg = "#fabd2f" },
				-- ["@constant.builtin"] = { link = "Special" }
				Normal = { bg = "#1d2021" },
				NormalFloat = { bg = "#1d2021" },
				NormalNC = { bg = "#1d2021" },
				Special = { fg = "#8ec07c" }, -- includes custom components for React
				WinBar = { fg = "#fbf1c7", bg = "#282828" },
				WinBarNC = { fg = "#bdae93", bg = "#3c3836" },
			},
			dim_inactive = true,
			transparent_mode = true,
		},
	},

	-- {
	--   "sainnhe/gruvbox-material",
	--   lazy = false,
	--   priority = 1000,
	--   config = function()
	--     vim.g.gruvbox_material_better_performance = 1
	--     -- Fonts
	--     vim.g.gruvbox_material_disable_italic_comment = 1
	--     vim.g.gruvbox_material_enable_italic = 0
	--     vim.g.gruvbox_material_enable_bold = 1
	--     vim.g.gruvbox_material_transparent_background = 0
	--     -- Themes
	--     vim.g.gruvbox_material_foreground = "mix"
	--     vim.g.gruvbox_material_background = "hard"
	--     vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
	--     vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
	--     vim.g.gruvbox_material_statusline_style = "mix"
	--
	--     vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
	--   end,
	-- },

	{
		"luisiacc/gruvbox-baby",
	},

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}
