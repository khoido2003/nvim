return {
	{
		"khoido2003/monokai-v2.nvim",
		priority = 1000,
		config = function()
			require("monokai-v2").setup({
				-- classic | light | machine | octagon | pro | ristretto | spectrum
				filter = "pro",
			})
			vim.cmd("colorscheme monokai-v2")
		end,
	},
}
