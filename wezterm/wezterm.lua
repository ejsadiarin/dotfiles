local wezterm = require("wezterm")
local config = wezterm.config_builder()

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
-- config.leader = { key = "Space", mods = "CTRL|SHIFT" }
-- config.keys = {
-- 	{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
-- }

-- shell
if host_os == "linux" then
	config.default_prog = { "zsh" }
elseif host_os == "windows" then
	config.default_prog = { "pwsh", "-NoLogo" }
end

-- tabs
config.enable_tab_bar = false

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

return config
