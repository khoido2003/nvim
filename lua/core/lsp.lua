local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

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
	},
	debug = true,
	timeout = 5000,
})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

------------------------------------------------------------
-- LSP MANAGE INSTALLER

-- Ensure the LSP servers are installed
mason.setup()
mason_lspconfig.setup({
	ensure_installed = {
		"pyright",
		"ts_ls",
		"gopls",
		"clangd",
		"jdtls",
		"html",
		"cssls",
		"yamlls",
		"tailwindcss",
		"lua_ls",
		"rust_analyzer",
	},
	automatic_installation = true,
})

-----------------------------------------------------------
-- LSP SETUP

-- Common capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Common on_attach function
local on_attach = function(client, bufnr)
	if client.server_capabilities.codeLensProvider then
		client.server_capabilities.codeLensProvider = false
	end
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)

	-- Print a message when the LSP is attached
	print("LSP attached for buffer: " .. bufnr)
end

-- Lua
lspconfig.lua_ls.setup({
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
	on_attach = on_attach,
})

-- Typescript
lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Python
lspconfig.pyright.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		-- Additional settings for Python
	end,
	settings = {
		python = {
			codelenses = { generate = false },
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- C/C++
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Docker
lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Yaml
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Go
lspconfig.gopls.setup({
	settings = {
		gopls = {
			directoryFilters = { "-node_modules", "-vendor", "-.git" },
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
			},
			staticcheck = true,
			semanticTokens = true,
			codelenses = { generate = false },
		},
	},
	flags = { debounce_text_changes = 150 },

	on_attach = on_attach,
	capabilities = capabilities,
})

-- Html
lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Css
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Tailwind
lspconfig.tailwindcss.setup({
	filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Java
lspconfig.jdtls.setup({

	root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
	settings = {
		java = {
			codelenses = { generate = false },
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Rust
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})
