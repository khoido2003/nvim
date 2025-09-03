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
			require("roslyn_filewatch").setup({
				client_names = { "roslyn_ls" },
				ignore_dirs = {
					"Library",
					"Temp",
					"Logs",
					"Obj",
					"Bin",
					".git",
					".idea",
					".vs",
				},
				watch_extensions = { ".cs", ".csproj", ".sln", ".props", ".targets" },
				batching = {
					enabled = true,
					interval = 100,
				},
			})
		end,
	},
}
