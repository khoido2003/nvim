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
					vim.lsp.buf.signature_help()
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
					gopls = { staticcheck = true },
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
					"--memory-limit:8192",
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
						DocumentAnalysisTimeoutMs = 5000,
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

			-- svelte = {
			-- 	cmd = { "svelteserver", "--stdio" },
			-- 	filetypes = { "svelte" },
			-- },

			-- html = {
			-- 	filetypes = {
			-- 		"html",
			-- 		"css",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 		"vue",
			-- 		"svelte",
			-- 	},
			-- },
			--
			-- cssls = {
			-- 	filetypes = { "css", "scss", "less", "svelte" },
			-- },
			--
			-- tailwindcss = {
			-- 	filetypes = {
			-- 		"html",
			-- 		"css",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 		"vue",
			-- 		"svelte",
			-- 	},
			-- },

			-- jdtls = {
			-- 	root_dir = function(fname)
			-- 		return require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git")(fname)
			-- 			or vim.fn.getcwd()
			-- 	end,
			-- 	settings = {
			-- 		java = {
			-- 			signatureHelp = { enabled = true },
			-- 			completion = {
			-- 				favoriteStaticMembers = {
			-- 					"org.junit.Assert.*",
			-- 					"org.hamcrest.Matchers.*",
			-- 					"org.hamcrest.CoreMatchers.*",
			-- 					"java.util.Objects.requireNonNull",
			-- 					"java.util.Objects.requireNonNullElse",
			-- 					"java.util.Collections.emptyList",
			-- 				},
			-- 				filteredTypes = {
			-- 					"com.sun.*",
			-- 					"io.micrometer.shaded.*",
			-- 					"java.awt.*",
			-- 					"jdk.*",
			-- 					"sun.*",
			-- 				},
			-- 			},
			-- 			contentProvider = { preferred = "fernflower" },
			-- 			sources = {
			-- 				organizeImports = {
			-- 					starThreshold = 3,
			-- 					staticStarThreshold = 3,
			-- 				},
			-- 			},
			-- 			codeGeneration = {
			-- 				toString = {
			-- 					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			-- 				},
			-- 				useBlocks = true,
			-- 			},
			-- 			eclipse = { downloadSources = true },
			-- 			format = {
			-- 				enabled = true,
			-- 				settings = {
			-- 					profile = "GoogleStyle",
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- },

			-- pyright = {
			-- 	settings = {
			-- 		python = {
			-- 			analysis = {
			-- 				typeCheckingMode = "basic",
			-- 				autoSearchPaths = true,
			-- 			},
			-- 		},
			-- 	},
			-- },
			--
			-- clangd = {
			-- 	on_attach = on_attach,
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--background-index",
			-- 		"--pch-storage=memory",
			-- 		"--all-scopes-completion",
			-- 		"--pretty",
			-- 		"--header-insertion=never",
			-- 		"-j=4",
			-- 		"--inlay-hints",
			-- 		"--header-insertion-decorators",
			-- 		"--function-arg-placeholders",
			-- 		"--completion-style=detailed",
			-- 	},
			-- 	filetypes = { "c", "cpp", "objc", "objcpp" },
			-- 	root_dir = require("lspconfig.util").root_pattern("meson.build", "src", "CMakeLists.txt", ".git"),
			-- 	init_option = { fallbackFlags = { "-std=c++2a" } },
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		["clangd"] = {
			-- 			fileStatus = true,
			-- 		},
			-- 	},
			-- },

			-- gdscript = {
			-- 	cmd = vim.fn.has("win32") == 1 and { "ncat", "localhost", "6005" }
			-- 		or { "ncat", "localhost", "6005" },
			-- 	flags = { debounce_text_changes = 200 },
			-- },
		}
		for server, config in pairs(servers) do
			config.on_attach = on_attach
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end
	end,
}
