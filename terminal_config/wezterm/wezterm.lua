local wezterm = require("wezterm")
local act = wezterm.action

local palette = require("classic")

wezterm.on("format-tab-title", function(tab)
	return " " .. tostring(tab.tab_index + 1) .. " "
end)

local config = {
	enable_wayland = false,
	check_for_updates = false,

	window_frame = {
		active_titlebar_bg = palette.background,
		inactive_titlebar_bg = palette.background,

		active_titlebar_fg = palette.foreground,
		inactive_titlebar_fg = palette.neutral3,

		active_titlebar_border_bottom = palette.background,
		inactive_titlebar_border_bottom = palette.background,

		button_bg = palette.background,
		button_fg = palette.foreground,
		button_hover_bg = palette.neutral5,
		button_hover_fg = palette.red,
	},

	colors = {
		foreground = palette.foreground,
		background = palette.background,

		cursor_bg = palette.foreground,
		cursor_border = palette.foreground,
		cursor_fg = palette.background,

		selection_bg = palette.neutral5,
		selection_fg = palette.foreground,

		ansi = {
			palette.surface0,
			palette.red,
			palette.green,
			palette.yellow,
			palette.delimiter_blue,
			palette.purple,
			palette.cyan,
			palette.foreground,
		},
		brights = {
			palette.neutral3,
			palette.delimiter_pink,
			palette.delimiter_green,
			palette.delimiter_yellow,
			palette.delimiter_blue,
			palette.delimiter_purple,
			palette.delimiter_cyan,
			"#ffffff",
		},

		tab_bar = {
			background = palette.background,

			active_tab = {
				bg_color = palette.neutral5,
				fg_color = palette.foreground,
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},

			inactive_tab = {
				bg_color = palette.background,
				fg_color = palette.neutral3,
			},

			inactive_tab_hover = {
				bg_color = palette.neutral5,
				fg_color = palette.foreground,
				italic = true,
			},

			new_tab = {
				bg_color = palette.background,
				fg_color = palette.neutral3,
			},

			new_tab_hover = {
				bg_color = palette.neutral5,
				fg_color = palette.foreground,
				italic = true,
			},
		},
	},

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	show_close_tab_button_in_tabs = false,

	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	enable_scroll_bar = false,

	font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
	font_size = 10,

	window_close_confirmation = "NeverPrompt",

	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		{ key = " ", mods = "CTRL", action = act.SendKey({ key = " ", mods = "CTRL" }) },
	},

	default_prog = { "pwsh", "-NoLogo" },
}

return config
