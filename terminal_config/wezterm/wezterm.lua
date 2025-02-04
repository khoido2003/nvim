local wezterm = require("wezterm")
local gpus = wezterm.gui.enumerate_gpus()

local config = {
	window_frame = {
		active_titlebar_bg = "#282c34",
		inactive_titlebar_bg = "#1e222a",
	},

	show_close_tab_button_in_tabs = false,

	colors = {
		tab_bar = {
			background = "#282c34",
			active_tab = {
				bg_color = "#3e4451",
				fg_color = "#dcdfe4",
			},

			inactive_tab = {
				bg_color = "#1e222a",
				fg_color = "#abb2bf",
			},

			inactive_tab_hover = {
				bg_color = "#3e4451",
				fg_color = "#abb2bf",
			},

			-- New tab button
			new_tab = {
				bg_color = "#282c34",
				fg_color = "#abb2bf",
			},

			-- New tab (hovered)
			new_tab_hover = {
				bg_color = "#3e4451",
				fg_color = "#dcdfe4",
			},
		},
	},

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	window_decorations = "INTEGRATED_BUTTONS|RESIZE",

	enable_scroll_bar = false,
	color_scheme = "OneDark (base16)",

	-- Font settings
	font = wezterm.font("Fira Code"),

	font_size = 11,

	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 500,

	-- ////////////////////////////////

	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	webgpu_preferred_adapter = gpus[2],

	webgpu_force_fallback_adapter = false,

	max_fps = 60,
	allow_square_glyphs_to_overflow_width = "Always",

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	},
}

-- Tab renaming function
wezterm.on("format-tab-title", function(tab)
	return " " .. tostring(tab.tab_index + 1) .. " "
end)

return config
