local wezterm = require("wezterm")
local config = wezterm.config_builder()

local opacity = 1
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"
local host_os = require("utils").get_os()

-- colorscheme
config.color_scheme = "Batman"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Monokai Dark"

-- fonts
config.font = wezterm.font_with_fallback({
	{
		family = "IosevkaTerm Nerd Font Mono",
		stretch = "Expanded",
		weight = "Regular",
	},
	{
		family = "JetBrains Mono",
		weight = "Regular", -- Bold, Regular
		italic = false,
	},
})
config.font_size = 20

-- window styles
config.window_padding = {
	left = 5,
	right = 0,
	top = 15,
	bottom = 0,
}
-- config.window_background_image = '/path/to/wallpaper.jpg'
-- config.window_background_image_hsb = {
--   brightness = 0.3,
--   hue = 1.0,
--   saturation = 1.0,
-- }

-- cursor
config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- keybinds
-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

config.leader = { key = "Space", mods = "CTRL|SHIFT" }
config.keys = {
	{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
}

-- shell
if host_os == "linux" then
	config.default_prog = { "zsh" }
elseif host_os == "windows" then
	config.default_prog = { "pwsh", "-NoLogo" }
end

-- tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.nf_ple_upper_left_triangle
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle

-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.nf_ple_upper_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SLASH = wezterm.nerdfonts.fae_slash
local ARROW_EXPAND_RIGHT = wezterm.nerdfonts.md_arrow_expand_right

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end
config.use_fancy_tab_bar = false
config.tab_max_width = 1600

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local edge_background = "#2a2a40"
	local background = "#2a2a40"
	local foreground = "#808080"

	if tab.is_active then
		background = "#0a0a23"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#1b1b32"
		foreground = "#909090"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = "  " .. tab.tab_index + 1 .. " " .. ARROW_EXPAND_RIGHT .. " " .. title .. "  " },
		{ Background = { Color = edge_foreground } },
		{ Foreground = { Color = "#909090" } },
		{ Text = SLASH },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- config.colors = require("cyberdream")
-- config.colors.tab_bar = {
-- 	background = transparent_bg,
-- 	new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
-- 	new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
-- }
--
-- wezterm.on("format-tab-title", function(tab, _, _, _, hover)
-- 	local background = config.colors.brights[1]
-- 	local foreground = config.colors.foreground
--
-- 	if tab.is_active then
-- 		background = config.colors.brights[7]
-- 		foreground = config.colors.background
-- 	elseif hover then
-- 		background = config.colors.brights[8]
-- 		foreground = config.colors.background
-- 	end
--
-- 	local title = tostring(tab.tab_index + 1)
-- 	return {
-- 		{ Foreground = { Color = background } },
-- 		{ Text = "█" },
-- 		{ Background = { Color = background } },
-- 		{ Foreground = { Color = foreground } },
-- 		{ Text = title },
-- 		{ Foreground = { Color = background } },
-- 		{ Text = "█" },
-- 	}
-- end)

return config
