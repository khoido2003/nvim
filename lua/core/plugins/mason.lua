return {
	{
		"mason-org/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = {
					-- "lua_ls",
					-- "ts_ls",
					-- "pyright",
					-- "clangd",
					-- "jdtls",
					-- "html",
					-- "cssls",
					-- "yamlls",
					-- "tailwindcss",
					-- "omnisharp",
					-- "rust_analyzer",
					-- "gopls",
				},
			})
		end,
	},
}
