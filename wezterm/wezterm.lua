local wezterm = require("wezterm")

local config = {
	-- Remove padding for a snappier experience
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Font settings
	font = wezterm.font("Fira Code"),
	font_size = 11,

	-- Tab bar settings
	tab_bar_at_bottom = true,

	-- GPU and performance optimization
	enable_kitty_graphics = true,
	enable_wayland = false,

	max_fps = 60,
	animation_fps = 1,
	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 1000,

	front_end = "OpenGL",

	allow_square_glyphs_to_overflow_width = "Always",

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	},
}

-- Tab renaming function
wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
	local process_name = tab.active_pane.foreground_process_name or ""
	process_name = process_name:match("([^/\\]+)$") or process_name
	return process_name
end)

return config
