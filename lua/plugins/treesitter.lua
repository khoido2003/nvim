return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {},
				auto_install = true,
				sync_install = true,

				modules = {},
				ignore_install = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = false,
				},
			})

			vim.api.nvim_create_autocmd("BufReadPre", {
				callback = function()
					if vim.fn.line("$") > 15000 then
						vim.cmd("TSBufDisable highlight")
					end
				end,
			})
			require("nvim-treesitter.install").compilers = { "gcc", "zig" }
		end,
	},
}
