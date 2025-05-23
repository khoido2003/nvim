local wezterm = require("wezterm")
-- local gpus = wezterm.gui.enumerate_gpus()

-- RUN this on window with powershell 7 for recommendation

-- Install-Module PSReadLine -Force -SkipPublisherCheck
-- Set-PSReadLineOption -PredictionSource HistoryAndPlugin
-- Set-PSReadLineOption -Colors @{ InLinePrediction = '#8A2BE2' }

local config = {
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	show_close_tab_button_in_tabs = false,
	front_end = "OpenGL",
	max_fps = 60,
	animation_fps = 1,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	enable_kitty_graphics = true,
	anti_alias_custom_block_glyphs = false,

	enable_scroll_bar = false,
	color_scheme = "Hardcore (base16)",

	-- Font settings
	-- font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" }),
	font = wezterm.font("Consolas", { weight = "Regular" }),
	font_size = 11.5,

	window_close_confirmation = "NeverPrompt",
	scrollback_lines = 100,

	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	keys = {
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	},

	-- Uncomment and change this to the correct directory

	-- default_prog = { "D:\\powershell\\7\\pwsh.exe" },
	--
	-- launch_menu = {
	-- 	{
	-- 		label = "PowerShell 7",
	-- 		args = { "D:\\powershell\\7\\pwsh.exe" },
	-- 	},
	-- },
}

-- Tab renaming function
wezterm.on("format-tab-title", function(tab)
	return " " .. tostring(tab.tab_index + 1) .. " "
end)

return config
