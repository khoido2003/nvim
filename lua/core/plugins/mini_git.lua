return {
	{
		"echasnovski/mini.diff",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>rh", "<cmd>lua MiniDiff.do_hunks(0, 'reset')<CR>", mode = "x", desc = "Reset hunks (visual)" },
			{
				"<leader>rb",
				function()
					require("mini.diff").do_hunks(0, "reset", { line_start = 1, line_end = vim.fn.line("$") })
				end,
				desc = "Reset entire buffer",
			},
			{ "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<CR>", desc = "Toggle diff overlay" },
		},
		config = function()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "+", change = "~", delete = "-" },
					priority = 5,
				},
				source = require("mini.diff").gen_source.git(),
				options = {
					algorithm = "histogram",
					indent_heuristic = true,
					linematch = 60,
					wrap_goto = false,
				},
			})
		end,
	},
	{
		"echasnovski/mini-git",
		version = "*",
		main = "mini.git",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>gb", "<cmd>vert Git blame -- %<CR>", desc = "Show Git blame" },
		},
		config = function()
			require("mini.git").setup({
				job = {
					git_executable = "git",
					timeout = 10000,
				},
				command = {
					split = "auto",
				},
			})
		end,
	},
}
