return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy" },
	dependencies = {
		{ "saghen/blink.cmp" },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			roslyn_ls = {

				settings = {
					["csharp|background_analysis"] = {
						dotnet_analyzer_diagnostics_scope = "openFiles",
						dotnet_compiler_diagnostics_scope = "openFiles",
					},
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = false,
						csharp_enable_inlay_hints_for_implicit_variable_types = false,
						csharp_enable_inlay_hints_for_lambda_parameter_types = false,
						csharp_enable_inlay_hints_for_types = false,
						dotnet_enable_inlay_hints_for_indexer_parameters = false,
						dotnet_enable_inlay_hints_for_literal_parameters = false,
						dotnet_enable_inlay_hints_for_object_creation_parameters = false,
						dotnet_enable_inlay_hints_for_other_parameters = false,
						dotnet_enable_inlay_hints_for_parameters = false,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = false,
					},
				},
			},
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
			vim.lsp.config(
				server,
				vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 300,
					},
				}, config or {})
			)

			vim.lsp.enable(server)
		end
	end,
}
