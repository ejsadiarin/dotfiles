#!/usr/bin/env bash
#  ╔═╗╔═╗╔╦╗╔═╗╦  ╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠═╝╠═╣║║║║╣ ║  ╠═╣  ╠╦╝║║  ║╣	https://github.com/gh0stzk/dotfiles
#  ╩  ╩ ╩╩ ╩╚═╝╩═╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Pamela
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 59
	bspc config bottom_padding 2
	bspc config normal_border_color "#C574DD"
	bspc config active_border_color "#C574DD"
	bspc config focused_border_color "#8897F4"
	bspc config presel_feedback_color "#FF4971"
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config window_gap 6
}

# Reload terminal colors
set_term_config() {
	sed -i "$HOME"/.config/alacritty/fonts.toml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"

	cat >"$HOME"/.config/alacritty/colors.toml <<-_EOF_
		        # Exquisite Colors
		            [colors.bright]
		            black =  "#626483"
		            red =    "#fb007a"
		            green =  "#a6e22e"
		            yellow = "#f3e430"
		            blue =   "#58AFC2"
		            magenta = "#472575"
		            white =  "#f1f1f1"
		            cyan =   "#926BCA"

		            [colors.cursor]
		            cursor = "#ffffff"
		            text = "#070219"

		            [colors.normal]
		            black =   "#626483"
		            red =     "#fb007a"
		            green =   "#a6e22e"
		            yellow =  "#f3e430"
		            blue =    "#58AFC2"
		            magenta = "#583794"
		            cyan =    "#926BCA"
		            white =   "#d9d9d9"

		            [colors.primary]
		            background = "#1d2021"
		            foreground = "#c0caf5"

		        # colors:
		        #   primary:
		        #     background: '#1d2021'
		        #     foreground: '#c0caf5'
		        #
		        #   normal:
		        #     black:   '#626483'
		        #     red:     '#fb007a'
		        #     green:   '#a6e22e'
		        #     yellow:  '#f3e430'
		        #     blue:    '#58AFC2'
		        #     magenta: '#583794'
		        #     cyan:    '#926BCA'
		        #     white:   '#d9d9d9'
		        #
		        #   bright:
		        #     black:   '#626483'
		        #     red:     '#fb007a'
		        #     green:   '#a6e22e'
		        #     yellow:  '#f3e430'
		        #     blue:    '#58AFC2'
		        #     magenta: '#472575'
		        #     cyan:    '#926BCA'
		        #     white:   '#f1f1f1'
		        #
		        #   cursor:
		        #     cursor: '#ffffff'
		        #     text: '#070219'
	_EOF_
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"90:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"90:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 9/g" \
		-e "s/frame_color = .*/frame_color = \"#1D1F28\"/g" \
		-e "s/separator_color = .*/separator_color = \"#8897F4\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#79E6F3'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#1D1F28"
		foreground = "#FDFDFD"

		[urgency_normal]
		timeout = 6
		background = "#1D1F28"
		foreground = "#FDFDFD"

		[urgency_critical]
		timeout = 0
		background = "#1D1F28"
		foreground = "#FDFDFD"
	_EOF_
}

# Launch the bar
launch_bars() {
	eww -c ${rice_dir}/widgets daemon &
	polybar -q archlogo -c ${rice_dir}/config.ini &
	polybar -q workspacebar -c ${rice_dir}/config.ini &
	# polybar -q traybar -c ${rice_dir}/config.ini &
	polybar -q datetimebar -c ${rice_dir}/config.ini &
	polybar -q statusbar -c ${rice_dir}/config.ini &
	polybar -q powerbar -c ${rice_dir}/config.ini &
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
launch_bars
