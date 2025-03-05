return {
	-- Telescope for Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		cmd = "Telescope",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = { file_ignore_patterns = { "node_modules", ".git/*", "*.log" } },
				extensions = {
					lsp_handlers = {
						code_action = { telescope = require("telescope.themes").get_dropdown({}) },
					},
				},
			})
		end,
	},
}
