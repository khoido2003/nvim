local wezterm = require("wezterm")
local gpus = wezterm.gui.enumerate_gpus()

local config = {
	-- Remove padding for a snappier experience
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Disable scrollbar
	enable_scroll_bar = false,
	color_scheme = "Vs Code Dark+ (Gogh)",

	-- Font settings

	font = wezterm.font("Fira Code"),

	font_size = 10.5,

	-- Tab bar settings
	tab_bar_at_bottom = true,

	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 1000,

	freetype_load_target = "Normal",
	freetype_render_target = "HorizontalLcd",
	-- ////////////////////////////////

	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	webgpu_preferred_adapter = gpus[2],

	webgpu_force_fallback_adapter = false,

	max_fps = 60, -- Match your monitor refresh rate
	-- ////////////////////////////////////////

	allow_square_glyphs_to_overflow_width = "Always",

	default_prog = { "C:\\Users\\Lenovo\\AppData\\Local\\Programs\\nu\\bin\\nu.exe", "--login" },
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
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

-- //////////////////////////////////////
