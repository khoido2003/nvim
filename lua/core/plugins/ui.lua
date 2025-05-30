return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufReadPost",
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
	-- Auto pair
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "BufReadPost",
		config = function()
			require("mini.pairs").setup({})
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
	},
}
