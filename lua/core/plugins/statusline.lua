return {
	{
		"echasnovski/mini.statusline",
		event = "BufReadPost",
		version = "*",
		lazy = true,
		config = function()
			require("mini.statusline").setup({})
		end,
	},
}
