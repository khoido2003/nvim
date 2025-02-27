return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			-- Formatter setup
			require("conform").setup({
				formatters_by_ft = {
					html = { "prettier" },
					css = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					javascriptreact = { "prettier" },
					scss = { "prettier" },
					jsx = { "prettier" },
					tsx = { "prettier" },
					json = { "prettier" },
					python = { "black" },
					go = { "gofmt" },
					lua = { "stylua" },
					proto = { "buf" },
					rust = { "rustfmt" },
					yaml = { "yamlfmt" },
					java = { "astyle" },
					c = { "astyle" },
					cpp = { "astyle" },
					cs = { "csharpier" },
					gdscript = { "gdformat" },
				},
				debug = true,
				timeout = 10000,
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf, async = true })
				end,
			})
		end,
	},
}
