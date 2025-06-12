return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		keys = { "<c-\\>", "<C-t>" },
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				direction = "tab",
				shade_terminals = true,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				-- shell = "pwsh",
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup({})
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
	},
}
