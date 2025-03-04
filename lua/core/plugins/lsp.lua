return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- LSP diagnostics
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
					source = "if_many", -- Only show if multiple diagnostics, reduces clutter
					update_in_insert = false, -- Unchanged, avoids insert-mode redraws
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				float = { border = "rounded" }, -- Optional: cleaner popup look
			})

			-- Diagnostic signs (unchanged, lightweight)
			local signs = {
				{ name = "Error", text = "E" },
				{ name = "Warn", text = "W" },
				{ name = "Hint", text = "H" },
				{ name = "Info", text = "I" },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define("DiagnosticSign" .. sign.name, {
					text = sign.text,
					texthl = "Diagnostic" .. sign.name,
				})
			end

			local on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				-- LSP Mappings
				local lsp_mappings = {
					{ "<leader>gd", "vim.lsp.buf.definition()" },
					{ "<leader>k", "vim.lsp.buf.hover()" },
					{ "<leader>rn", "vim.lsp.buf.rename()" },
					{ "<leader>gr", "vim.lsp.buf.references()" },
					{ "<leader>gt", "vim.lsp.buf.type_definition()" },
					{ "<leader>sh", "vim.lsp.buf.signature_help()" },
					{ "<leader>ca", "vim.lsp.buf.code_action()" },
				}

				for _, mapping in ipairs(lsp_mappings) do
					vim.keymap.set(
						"n",
						mapping[1],
						"<Cmd>lua " .. mapping[2] .. "<CR>",
						{ noremap = true, silent = true }
					)
				end

				-- Keybinding to open diagnostics in a floating window
				vim.api.nvim_set_keymap(
					"n",
					"<Leader>d",
					":lua vim.diagnostic.open_float()<CR>",
					{ noremap = true, silent = true }
				)

				print("LSP server '" .. client.name .. "' started successfully!")
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
				gdscript = {
					cmd = vim.fn.has("win32") == 1 and { "ncat", "localhost", "6005" }
						or { "ncat", "localhost", "6005" },
					flags = { debounce_text_changes = 200 },
				},
			}
			for server, config in pairs(servers) do
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}
