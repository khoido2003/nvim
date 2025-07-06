return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
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

			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = function()
						local project_dir = vim.fn.expand("%:p:h")
						local csproj_files = vim.fn.glob(project_dir .. "/*.csproj", true, true)
						for _, file in ipairs(csproj_files) do
							if file:match("Assembly%-CSharp%.csproj$") then
								return { "--project", file }
							end
						end

						return {}
					end,
				},
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, async = true })
			end,
		})
	end,
}
