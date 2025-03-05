return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			-- Mason setup
			mason.setup()
			mason_lspconfig.setup({
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
				automatic_installation = false, -- Run :MasonInstall manually if needed
			})
		end,
	},
}
