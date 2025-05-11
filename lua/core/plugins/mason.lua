return {
	{
		"mason-org/mason.nvim",
		branch = "v1.x",
		event = "VeryLazy",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		branch = "v1.x",
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
