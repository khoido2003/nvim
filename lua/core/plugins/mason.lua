return {
	{
		"mason-org/mason.nvim",
		event = "VeryLazy",
		version = "1.11.0",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		version = "1.32.0",
		event = "VeryLazy",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
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
				automatic_installation = false,
			})
		end,
	},
}
