return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufReadPost",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
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
		config = function()
			require("nvim-autopairs").setup({ check_ts = true })
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup()
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
	},
}
