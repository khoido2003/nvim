return {
	"neovim/nvim-lspconfig",
	event = { "LspAttach" },
	dependencies = {
		{ "saghen/blink.cmp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			client.server_capabilities.codeLensProvider = false
			client.server_capabilities.documentHighlightProvider = false
			client.server_capabilities.foldingRangeProvider = false
			client.server_capabilities.inlayHintProvider = false
		end

		-- Lua lsp
		vim.lsp.enable("lua_ls")

		-- C# lsp
		vim.lsp.enable("roslyn_ls")

		-- TS/JS lsp
		vim.lsp.enable("ts_ls")

		-- Go lsp
		vim.lsp.enable("gopls")

		-- Rust lsp
		vim.lsp.enable("rust_analyzer")

		-- Config server
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.fn.expand("$VIMRUNTIME/lua"),
								vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
								"${3rd}/love2d/library",
							},
							checkthirdparty = false,
						},
						telemetry = { enable = false },
					},
				},
			},
		}
		for server, config in pairs(servers) do
			config.on_attach = on_attach
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end
	end,
}
