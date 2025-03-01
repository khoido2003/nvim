return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				local opts = { noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>f", function()
					require("conform").format({ async = true })
				end, opts)
				print("LSP started successfully!")
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
								library = vim.api.nvim_get_runtime_file("", true),
								checkthirdparty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
				ts_ls = { init_options = { maxTsServerMemory = 3072 } },
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
							},
						},
					},
				},
				-- clangd = {},
				-- dockerls = {},
				-- yamlls = {},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = false,
						},
					},
					flags = { debounce_text_changes = 150 },
				},
				html = {},
				cssls = {},
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"vue",
						"svelte",
					},
				},
				-- omnisharp = {},
				-- jdtls = {
				-- 	root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
				-- },
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { features = "default" },
							checkOnSave = { command = "clippy" },
							diagnostics = {
								enable = true,
								experimental = { enable = true },
							},
						},
					},
				},
				gdscript = vim.fn.has("win32") == 1 and { cmd = { "ncat", "localhost", "6005" } } or {},
			}
			for server, config in pairs(servers) do
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}
