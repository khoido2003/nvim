return {
	{
		"echasnovski/mini.diff",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "+", change = "~", delete = "-" },
					priority = 10,
				},
				source = require("mini.diff").gen_source.git(),
				options = {
					algorithm = "histogram",
					indent_heuristic = true,
					linematch = 60,
					wrap_goto = false,
				},
			})

			-- Keymappings for mini.diff
			local opts = { noremap = true, silent = true, buffer = true }

			vim.keymap.set(
				"x",
				"<leader>rh",
				"<cmd>lua MiniDiff.do_hunks(0, 'reset')<CR>",
				vim.tbl_extend("force", opts, { desc = "Reset hunks (visual)" })
			)

			-- Reset entire buffer
			vim.keymap.set("n", "<leader>rb", function()
				require("mini.diff").do_hunks(0, "reset", { line_start = 1, line_end = vim.fn.line("$") })
			end, vim.tbl_extend("force", opts, { desc = "Reset entire buffer" }))

			-- Toggle overlay
			vim.keymap.set(
				"n",
				"<leader>go",
				"<cmd>lua MiniDiff.toggle_overlay()<CR>",
				vim.tbl_extend("force", opts, { desc = "Toggle diff overlay" })
			)
		end,
	},
	{
		"echasnovski/mini-git",
		version = "*",
		main = "mini.git",
		event = { "BufReadPre", "BufNewFile" },
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

			-- Keymappings for mini-git
			local opts = { noremap = true, silent = true, buffer = true }
			vim.keymap.set(
				"n",
				"<leader>gb",
				"<cmd>vert Git blame -- %<CR>",
				vim.tbl_extend("force", opts, { desc = "Show Git blame" })
			)
		end,
	},
}
