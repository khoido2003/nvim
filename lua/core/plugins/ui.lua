return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufReadPost",
		config = function()
			vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f92672" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9955" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ffd700" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#179fff" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#da70d6" })
		end,
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
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("nvim-autopairs").setup({
				check_ts = false,
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		lazy = true,
		config = function()
			require("colorizer").setup({})
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	-- Multiple cursor
	{
		"mg979/vim-visual-multi",
		event = "BufReadPost",
		lazy = true,
	},
}
