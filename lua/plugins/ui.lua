return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
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
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimtools/hydra.nvim",
			lazy = true,
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				stages = "static",
				timeout = 1000,
				render = "minimal",
				max_width = 50,
				max_height = 5,
				fps = 30,
				top_down = false,
			})

			vim.notify = notify
		end,
	},
}
