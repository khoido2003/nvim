return {
	{
		"sindrets/diffview.nvim",
		dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = function()
			require("diffview").setup({})
		end,
	},
}
