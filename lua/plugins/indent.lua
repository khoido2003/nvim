return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("ibl").setup({
			indent = {
				char = "┊",
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
					"help",
					"markdown",
					"gitcommit",
					"TelescopePrompt",
				},
				buftypes = { "terminal", "nofile" },
			},
		})
	end,
}
