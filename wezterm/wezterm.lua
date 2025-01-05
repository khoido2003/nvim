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

		foreground = "#D8DEE9", -- Nordic white1 for text
		background = "#242933", -- Nordic gray0 for the base background

		-- -- cursor colors
		-- cursor_bg = "#D8DEE9", -- Nordic white1 for the cursor
		-- cursor_fg = "#242933", -- Nordic gray0 for the cursor foreground
		-- cursor_border = "#D8DEE9", -- Cursor border matches cursor color

		-- Selection
		selection_fg = "#D8DEE9", -- Nordic white1 for selected text
		selection_bg = "rgba(57, 53, 82, 0.7)", -- Similar to Rose Pine but unchanged

		-- ANSI colors
		ansi = {
			"#242933", -- Black (Nordic gray0)
			"#BF616A", -- Red (Nordic red.base)
			"#A3BE8C", -- Green (Nordic green.base)
			"#EBCB8B", -- Yellow (Nordic yellow.base)
			"#5E81AC", -- Blue (Nordic blue0)
			"#B48EAD", -- Magenta (Nordic magenta.base)
			"#8FBCBB", -- Cyan (Nordic cyan.base)
			"#D8DEE9", -- White (Nordic white1)
		},

		-- Bright colors
		brights = {
			"#3B4252", -- Bright black (Nordic gray2)
			"#BF616A", -- Bright red (Nordic red.base)
			"#A3BE8C", -- Bright green (Nordic green.base)
			"#EBCB8B", -- Bright yellow (Nordic yellow.base)
			"#81A1C1", -- Bright blue (Nordic blue1)
			"#B48EAD", -- Bright magenta (Nordic magenta.base)
			"#8FBCBB", -- Bright cyan (Nordic cyan.base)
			"#ECEFF4", -- Bright white (Nordic white3)
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
	local active_background = "#4c566a"
	local active_foreground = "#e5e9f0"
	local inactive_background = "#313244"
	local inactive_foreground = "#aab2bf"
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
			File = "C:/Users/Lenovo/OneDrive/Pictures/arcane-11.jpg",

			-- File = "C:/Users/Lenovo/OneDrive/Pictures/g7.jpg",
		},

		hsb = dimmer,
	},
}

return config
