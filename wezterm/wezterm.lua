local wezterm = require("wezterm")
local config = wezterm.config_builder()
local custom = require("custom")

local host_os = require("utils").get_os()

-- colorscheme
config.color_scheme = "Custom"
-- config.color_scheme = "Batman"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Monokai Dark"
config.color_schemes = {
	["Custom"] = {
		foreground = "#fcffb8",
		background = "#1a1c1d",

		cursor_bg = "#fcef0b",
		cursor_fg = "#16181a",
		cursor_border = "#fcef0b",

		selection_fg = "#ffffff",
		selection_bg = "#3c4048",

		-- gray #6E6E6E
		-- #a2e57a
		scrollbar_thumb = "#1a1c1d",
		split = "#1a1c1d",

		ansi = {
			"#16181a",
			"#ff6e5e",
			"#5eff6c",
			"#f1ff5e",
			"#5ea1ff",
			"#bd5eff",
			"#5ef1ff",
			"#ffffff",
		},
		brights = {
			"#3c4048",
			"#ff6e5e",
			"#5eff6c",
			"#f1ff5e",
			"#5ea1ff",
			"#bd5eff",
			"#5ef1ff",
			"#ffffff",
		},

		indexed = {
			[16] = "#ffbd5e",
			[17] = "#ff6e5e",
		},
	},
}

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
	{ family = "Symbols Nerd Font Mono", scale = 0.80 },
	{
		family = "NotoSansMono-Regular",
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
config.window_background_opacity = 1
if host_os == "macos" then
	config.window_background_opacity = 0.3
	config.macos_window_background_blur = 20
end
if host_os == "windows" then
	config.window_background_opacity = 0
	config.win32_system_backdrop = "Tabbed"
end
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
-- config.leader = { key = "Space", mods = "CTRL|SHIFT" }
config.keys = {
	-- { key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
}

-- shell
if host_os == "linux" then
	config.default_prog = { "zsh" }
elseif host_os == "windows" then
	config.default_prog = { "pwsh", "-NoLogo" }
end

-- tabs
config.enable_tab_bar = false

-- gpu
config.front_end = "WebGpu"

-- config.enable_kitty_keyboard = true
-- wezterm.on("window-config-reloaded", function(window, pane)
-- 	window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
-- end)

return config
