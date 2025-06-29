return {
	"stevearc/conform.nvim",
	event = "BufWritePost",
	lazy = true,
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
				svelte = { "prettier" },
				jsx = { "prettier" },
				tsx = { "prettier" },
				json = { "prettier" },
				python = { "black" },
				go = { "gofmt" },
				lua = { "stylua" },
				proto = { "buf" },
				rust = { "rustfmt" },
				java = { "astyle" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				cs = { "csharpier" },
				gdscript = { "gdformat" },
			},
			timeout = 7000,
			debug = true,
		})

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, async = true })
			end,
		})
	end,
}
