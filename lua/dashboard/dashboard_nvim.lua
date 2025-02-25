local function get_nvim_version()
	local v = vim.version()
	return string.format("  v%d.%d.%d", v.major, v.minor, v.patch)
end

require("dashboard").setup({
	theme = "doom",
	config = {
		header = {

			[[                                                                              ]],
			[[                                                                              ]],
			[[                                                                              ]],
			[[                                                                              ]],
			[[                                                                              ]],
			[[                                    ██████                                    ]],
			[[                                ████▒▒▒▒▒▒████                                ]],
			[[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
			[[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
			[[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
			[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
			[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
			[[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
			[[                        ██      ██      ████      ████                        ]],
			[[                                                                              ]],
			[[                                                                              ]],
			[[                                                                              ]],
			[[                                                                              ]],
		},

		center_opts = {
			position = "center",
		},

		center = {
			{
				icon = "  ",
				icon_hl = "Function", -- Use existing Monokai color
				desc = "Find File",
				desc_hl = "String", -- Monokai green
				key = "f",
				keymap = "SPC f f",
				key_hl = "Number", -- Monokai orange
				key_format = " %s",
				action = "Telescope find_files",
			},
			{
				icon = "  ",
				icon_hl = "Function",
				desc = "Recent Files",
				desc_hl = "String",
				key = "r",
				keymap = "SPC f r",
				key_hl = "Number",
				key_format = " %s",
				action = "Telescope oldfiles",
			},
			{
				icon = "  ",
				icon_hl = "Function",
				desc = "New File",
				desc_hl = "String",
				key = "n",
				keymap = "SPC c n",
				key_hl = "Number",
				key_format = " %s",
				action = "ene | startinsert",
			},
		},

		footer = {
			"",
			get_nvim_version(),
			"",
		},
		footer_hl = "Comment", -- Monokai-style footer color
	},
})
