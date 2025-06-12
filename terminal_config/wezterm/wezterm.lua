local wezterm = require("wezterm")

-- Tab renaming function
wezterm.on("format-tab-title", function(tab)
	return " " .. tostring(tab.tab_index + 1) .. " "
end)

local config = {
	enable_wayland = false,
	check_for_updates = false,

	-- Classic Monokai colorscheme
	window_frame = {
		active_titlebar_bg = "#272822",
		inactive_titlebar_bg = "#272822",

		active_titlebar_fg = "#f8f8f2",
		inactive_titlebar_fg = "#75715e",

		active_titlebar_border_bottom = "#272822",
		inactive_titlebar_border_bottom = "#272822",

		button_bg = "#272822",
		button_fg = "#f8f8f2",
		button_hover_bg = "#3e3d32",
		button_hover_fg = "#f92672",
	},

	colors = {
		cursor_bg = "#f8f8f0",
		cursor_fg = "#272822",
		cursor_border = "#f8f8f0",
		tab_bar = {
			background = "#272822",

			active_tab = {
				bg_color = "#49483e",
				fg_color = "#f8f8f2",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},

			inactive_tab = {
				bg_color = "#272822",
				fg_color = "#75715e",
			},

			inactive_tab_hover = {
				bg_color = "#49483e",
				fg_color = "#f8f8f2",
				italic = true,
			},

			new_tab = {
				bg_color = "#272822",
				fg_color = "#75715e",
			},

			new_tab_hover = {
				bg_color = "#49483e",
				fg_color = "#f8f8f2",
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

	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	max_fps = 120,
	animation_fps = 1,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	enable_kitty_graphics = false,
	anti_alias_custom_block_glyphs = false,

	enable_scroll_bar = false,

	color_scheme = "Monokai (dark) (terminal.sexy)",

	-- Font settings
	font = wezterm.font("BlexMono Nerd Font", { weight = "Regular" }),

	font_size = 10.5,

	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 100,

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	},

	default_prog = { "pwsh" },
}

return config
