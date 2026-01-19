return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy" },
	dependencies = {
		{ "saghen/blink.cmp" },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			roslyn_ls = {},
			ts_ls = {},
			gopls = {},
			rust_analyzer = {},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								vim.fn.expand("$VIMRUNTIME/lua"),
								vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
								"${3rd}/love2d/library",
							},
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},
		}

		for server, config in pairs(servers) do
			vim.lsp.config(server, vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {}))
			vim.lsp.enable(server)
		end
	end,
}
