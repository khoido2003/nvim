local wezterm = require("wezterm")

local act = wezterm.action
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local config = {

	dpi = 120.0,
	-- Window Config
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	adjust_window_size_when_changing_font_size = false,

	-- Tab config
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,
	-- tab_max_width = 16,

	-- Font Config

	font = wezterm.font("Fira Code", { weight = "Regular" }),

	font_size = 14.0,

	-- Color Style

	colors = {
		tab_bar = {
			background = "rgba(0,0,0,0)", -- Transparent background for tab bar
		},

		foreground = "#c9c7cd", -- Mellow foreground color
		background = "#161617", -- Mellow background color

		-- Cursor colors
		cursor_bg = "#e3e2e5", -- Mellow cursor background
		cursor_border = "#e3e2e5", -- Mellow cursor border
		cursor_fg = "#161617", -- Mellow cursor foreground

		-- Selection
		selection_fg = "#e3e2e5", -- Mellow selection foreground
		selection_bg = "#3c3b3e", -- Mellow selection background

		-- Scrollbar
		scrollbar_thumb = "#57575f", -- Mellow scrollbar thumb color
		split = "#57575f", -- Mellow split color

		-- ANSI colors
		ansi = {
			"#27272a", -- Black (Mellow)
			"#f5a191", -- Red (Mellow)
			"#90b99f", -- Green (Mellow)
			"#e6b99d", -- Yellow (Mellow)
			"#aca1cf", -- Blue (Mellow)
			"#e29eca", -- Magenta (Mellow)
			"#ea83a5", -- Cyan (Mellow)
			"#c1c0d4", -- White (Mellow)
		},

		-- Bright colors
		brights = {
			"#353539", -- Bright black (Mellow)
			"#ffae9f", -- Bright red (Mellow)
			"#9dc6ac", -- Bright green (Mellow)
			"#f0c5a9", -- Bright yellow (Mellow)
			"#b9aeda", -- Bright blue (Mellow)
			"#ecaad6", -- Bright magenta (Mellow)
			"#f591b2", -- Bright cyan (Mellow)
			"#cac9dd", -- Bright white (Mellow)
		},
	},
	-- Cursor
	cursor_thickness = 2,
	default_cursor_style = "SteadyBar",

	-- Keybindings
	keys = {
		{
			key = "w",
			mods = "CTRL|ALT",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "t",
			mods = "CTRL",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
	},
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

local function getTabTitle(tab_info)
	local processName = tab_info.active_pane.foreground_process_name
	return string.gsub(processName, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local active_background = "#1e1e22" -- Darker shade for active tab, still in line with mellow theme
	local active_foreground = "#e3e2e5" -- Light gray text for active tab
	local inactive_background = "#2a292f" -- Darker gray for inactive tabs, blending more into the background
	local inactive_foreground = "#7e7e88" -- Subtle light gray text for inactive tabs
	local transparent = "rgba(0,0,0,0)"
	-- local title = getTabTitle(tab)
	local index = tab.tab_index + 1
	local isFirst = index == 1
	local isLast = index == #tabs and #tabs ~= 0
	-- title = wezterm.truncate_right(title, max_width - 2)

	local items = {}

	if tab.is_active then
		table.insert(items, { Background = { Color = active_background } })
		table.insert(items, { Foreground = { Color = active_foreground } })
		table.insert(items, { Text = " " .. index .. " " })

		if isFirst then
			if #tabs > 1 then
				table.insert(items, { Background = { Color = inactive_background } })
				table.insert(items, { Foreground = { Color = active_background } })
			else
				table.insert(items, { Background = { Color = transparent } })
				table.insert(items, { Foreground = { Color = active_background } })
			end
		end

		if isLast then
			table.insert(items, { Background = { Color = transparent } })
			table.insert(items, { Foreground = { Color = active_background } })
		else
			table.insert(items, { Background = { Color = inactive_background } })
			table.insert(items, { Foreground = { Color = active_background } })
		end

		table.insert(items, { Text = "" })
	else
		table.insert(items, { Background = { Color = active_background } })
		table.insert(items, { Foreground = { Color = active_foreground } })
		table.insert(items, { Background = { Color = inactive_background } })
		table.insert(items, { Foreground = { Color = inactive_foreground } })
		table.insert(items, { Text = " " .. index .. " " })

		if isLast then
			table.insert(items, { Background = { Color = transparent } })
			table.insert(items, { Foreground = { Color = inactive_background } })
		else
			-- Check if the next tab is active
			if index - 1 < #tabs then
				local nextTab = tabs[index + 1]
				if nextTab.is_active then
					table.insert(items, { Background = { Color = active_background } })
					table.insert(items, { Foreground = { Color = inactive_background } })
				else
					table.insert(items, { Background = { Color = inactive_background } })
					table.insert(items, { Foreground = { Color = inactive_background } })
				end
			end
		end
		table.insert(items, { Text = "" })
	end

	return items
end)

local dimmer = { brightness = 0.1 }

config.background = {
	{
		source = {
			File = "C:/Users/Lenovo/OneDrive/Pictures/u14.jpg",

			-- File = "C:/Users/Lenovo/OneDrive/Pictures/g7.jpg",
		},

		hsb = dimmer,
	},
}

return config
