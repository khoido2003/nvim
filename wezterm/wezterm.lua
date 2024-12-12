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

		foreground = "#e0def4", -- Rose Pine text color
		background = "#18191a", -- Rose Pine base background

		-- cursor_bg = "#fff", -- Rose Pine rose accent color
		-- cursor_fg = "#18191a", -- Rose Pine base background for cursor

		selection_fg = "#e0def4", -- Rose Pine text color for selected text

		selection_bg = "rgba(57, 53, 82, 0.7)", -- Rose Pine overlay with 70% opacity

		ansi = {
			"#18191a", -- Black (base)
			"#eb6f92", -- Red (love)
			"#9ccfd8", -- Green (foam)
			"#ebbcba", -- Yellow (rose)
			"#31748f", -- Blue (pine)
			"#c4a7e7", -- Purple (iris)
			"#89d3c3", -- Teal (accent)
			"#e0def4", -- Silver (text)
		},

		brights = {
			"#18191a", -- Grey (base)
			"#eb6f92", -- Red (love)
			"#9ccfd8", -- Lime (foam)
			"#ebbcba", -- Yellow (rose)
			"#31748f", -- Blue (pine)
			"#c4a7e7", -- Fuchsia (iris)
			"#89d3c3", -- Aqua (accent)
			"#e0def4", -- White (text)
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
	local active_background = "#b4befe"
	local active_foreground = "#1e1e2e"
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

		table.insert(items, { Text = SOLID_RIGHT_ARROW })
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
		table.insert(items, { Text = SOLID_RIGHT_ARROW })
	end

	return items
end)

local dimmer = { brightness = 0.04 }

config.background = {
	{
		source = {
			File = "C:/Users/Lenovo/OneDrive/Pictures/arcane-11.jpg",
		},

		hsb = dimmer,
	},
}

return config
