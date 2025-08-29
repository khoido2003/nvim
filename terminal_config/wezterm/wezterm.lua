local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("format-tab-title", function(tab)
	return " " .. tostring(tab.tab_index + 1) .. " "
end)

local config = {
	enable_wayland = false,
	check_for_updates = false,

	-- Monokai Pro colorscheme
	window_frame = {
		active_titlebar_bg = "#2d2a2e", -- background
		inactive_titlebar_bg = "#2d2a2e",

		active_titlebar_fg = "#fcfcfa", -- foreground
		inactive_titlebar_fg = "#727072", -- neutral3 (comment color)

		active_titlebar_border_bottom = "#2d2a2e",
		inactive_titlebar_border_bottom = "#2d2a2e",

		button_bg = "#2d2a2e",
		button_fg = "#fcfcfa",
		button_hover_bg = "#403e41", -- neutral5
		button_hover_fg = "#ff6188", -- red
	},

	colors = {
		foreground = "#fcfcfa",
		background = "#2d2a2e",

		cursor_bg = "#fcfcfa",
		cursor_border = "#fcfcfa",
		cursor_fg = "#2d2a2e",

		selection_bg = "#403e41",
		selection_fg = "#fcfcfa",

		ansi = {
			"#1e1c1f", -- black (surface0)
			"#ff6188", -- red
			"#a9dc76", -- green
			"#ffd866", -- yellow
			"#6ab8ff", -- blue (delimiter_blue)
			"#ab9df2", -- purple
			"#78dce8", -- cyan
			"#fcfcfa", -- white (foreground)
		},
		brights = {
			"#727072", -- bright black (neutral3)
			"#ff6ac1", -- bright red (delimiter_pink)
			"#8aff80", -- bright green (delimiter_green)
			"#ffd866", -- bright yellow
			"#6ab8ff", -- bright blue
			"#bd93f9", -- bright purple (delimiter_purple)
			"#5ad4e6", -- bright cyan (delimiter_cyan)
			"#ffffff", -- bright white
		},

		tab_bar = {
			background = "#2d2a2e",

			active_tab = {
				bg_color = "#403e41",
				fg_color = "#fcfcfa",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},

			inactive_tab = {
				bg_color = "#2d2a2e",
				fg_color = "#727072",
			},

			inactive_tab_hover = {
				bg_color = "#403e41",
				fg_color = "#fcfcfa",
				italic = true,
			},

			new_tab = {
				bg_color = "#2d2a2e",
				fg_color = "#727072",
			},

			new_tab_hover = {
				bg_color = "#403e41",
				fg_color = "#fcfcfa",
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

	max_fps = 60,
	animation_fps = 1,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	enable_kitty_graphics = true,

	enable_scroll_bar = false,

	font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
	font_size = 10,

	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 100,

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		{ key = " ", mods = "CTRL", action = act.SendKey({ key = " ", mods = "CTRL" }) },
	},

	default_prog = { "pwsh", "-NoLogo" },
}

return config
