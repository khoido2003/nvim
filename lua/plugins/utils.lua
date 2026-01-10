return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup({})
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
		"mbbill/undotree",
		lazy = true,
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"jsx",
			"tsx",
			"vue",
			"svelte",
			"php",
			"markdown",
		},
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"jsx",
					"tsx",
					"vue",
					"svelte",
					"php",
					"markdown",
				},
			})
		end,
	},
	{
		"khoido2003/roslyn-filewatch.nvim",
		event = "VeryLazy",
		config = function()
			require("roslyn_filewatch").setup({})
		end,
	},
	{
		"khoido2003/multiple-cursor.nvim",
		keys = {
			{ "<C-n>", "<cmd>MultipleCursorStart<cr>", desc = "Start Multiple Cursor" },
		},
		cmd = { "MultipleCursorStart", "MultipleCursorSelectAll" },
		config = function()
			require("multiple-cursor").setup()
		end,
	},
}
