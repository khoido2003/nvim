return {
	"neovim/nvim-lspconfig",
	event = { "LspAttach" },
	dependencies = {
		{ "saghen/blink.cmp" },
		{
			"Hoffs/omnisharp-extended-lsp.nvim",
			lazy = true,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local lsp_mappings = {
			{
				"<leader>gd",
				function()
					if vim.bo.filetype == "cs" then
						require("omnisharp_extended").lsp_definitions()
					else
						vim.lsp.buf.definition()
					end
				end,
			},
			{
				"<leader>k",
				function()
					vim.lsp.buf.hover({ border = "single" })
				end,
			},
			{
				"<leader>rn",
				function()
					vim.lsp.buf.rename()
				end,
			},
			{
				"<leader>gr",
				function()
					require("telescope.builtin").lsp_references()
				end,
			},
			{
				"<leader>gt",
				function()
					vim.lsp.buf.type_definition()
				end,
			},
			{
				"<leader>sh",
				function()
					vim.lsp.buf.signature_help({ border = "single" })
				end,
			},
			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
			},
			{
				"<leader>d",
				function()
					vim.diagnostic.open_float(nil, {
						source = "always",
						border = "single",
					})
				end,
			},
		}
		for _, mapping in ipairs(lsp_mappings) do
			vim.keymap.set("n", mapping[1], mapping[2], { noremap = true, silent = true })
		end

		local on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			client.server_capabilities.codeLensProvider = false
			client.server_capabilities.documentHighlightProvider = false
			client.server_capabilities.foldingRangeProvider = false
			client.server_capabilities.inlayHintProvider = false
		end

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

			ts_ls = {
				init_options = {
					maxTsServerMemory = 3072,
					single_file_support = true,
				},
			},

			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unusedwrite = true,
							nilness = true,
						},
						codelenses = {
							gc_details = false,
						},
						usePlaceholders = true,
						completeUnimported = true,
						experimentalPostfixCompletions = true,
						staticcheck = true,
						matcher = "Fuzzy",
						diagnosticsDelay = "500ms",
						symbolMatcher = "fuzzy",
						gofumpt = false,
						directoryFilters = { "-vendor" },
					},
				},
			},

			omnisharp = {
				cmd = {
					"omnisharp",
					"--languageserver",
					"--hostPID",
					tostring(vim.fn.getpid()),
					"--encoding",
					"utf-8",
					"--memory-limit:4096",
				},
				filetypes = { "cs" },
				handlers = {
					["textDocument/definition"] = function(...)
						return require("omnisharp_extended").handler(...)
					end,
				},
				root_dir = function(fname)
					local root = require("lspconfig.util").root_pattern("*.sln", "*.csproj")(fname)
					return root or vim.fn.getcwd()
				end,

				settings = {
					FormattingOptions = {
						EnableEditorConfigSupport = false,
						OrganizeImports = false,
					},

					RoslynExtensionsOptions = {
						EnableAnalyzersSupport = false,
						EnableImportCompletion = true,
						EnableDecompilationSupport = false,
						DocumentAnalysisTimeoutMs = 3000,
						DiagnosticWorkersThreadCount = 2,
					},
					FileOptions = {
						SystemExcludeSearchPatterns = {
							"**/bin/**/*",
							"**/obj/**/*",
							"**/Library/**/*",
							"**/Temp/**/*",
							"**/node_modules/**/*",
							"**/dist/**/*",
							"**/packages/**/*",
							"**/.git/**/*",
							"**/.vs/**/*",
							"**/Logs/**/*",
							"**/ProjectSettings/**/*",
						},
						ExcludeSearchPatterns = {
							"**/bin/**/*",
							"**/obj/**/*",
							"**/Library/**/*",
							"**/Temp/**/*",
							"**/node_modules/**/*",
							"**/dist/**/*",
							"**/packages/**/*",
							"**/.git/**/*",
							"**/.vs/**/*",
							"**/Logs/**/*",
							"**/ProjectSettings/**/*",
						},
					},
					SdkOptions = {
						IncludePrerelease = false,
					},
				},
				init_options = {
					AutomaticWorkspaceInitialization = true,
					LoadProjectsOnDemand = true,
					UseModernNet = true,
				},
			},

			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { features = "default" },
						checkOnSave = { command = "clippy" },
						procMacro = {
							enable = true, -- Enable Anchor macros
						},
						diagnostics = {
							enable = true,
							experimental = { enable = false },
						},
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
