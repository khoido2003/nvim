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
		cs = { "csharpier" },
		gdscript = { "gdformat" },
	},
	debug = true,
	timeout = 10000,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf, async = true })
	end,
})

-- Mason setup
mason.setup()
mason_lspconfig.setup({
	ensure_installed = {
		-- "lua_ls",
		-- "ts_ls",
		-- "pyright",
		-- "clangd",
		-- "jdtls",
		-- "html",
		-- "cssls",
		-- "yamlls",
		-- "tailwindcss",
		-- "omnisharp",
		-- "rust_analyzer",
		-- "gopls",
	},
	automatic_installation = false, -- Run :MasonInstall manually if needed
})

-- Common LSP config
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
	-- Disable LSP formatting (conform handles it)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	-- Keymaps
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua require('conform').format({async=true})<CR>", opts)
	print("LSP started successfully!")
end

-- Server configs (minimal)
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
	pyright = { settings = { python = { analysis = { typeCheckingMode = "basic", autoSearchPaths = true } } } },
	clangd = {},
	dockerls = {},
	yamlls = {},
	gopls = {
		settings = { gopls = { analyses = { unusedparams = true }, staticcheck = false } },
		flags = { debounce_text_changes = 150 },
	},
	html = {},
	cssls = {},
	tailwindcss = {
		filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
	},
	omnisharp = {},
	jdtls = { root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle") },
	rust_analyzer = { settings = { ["rust-analyzer"] = { cargo = { features = "all" } } } },
	gdscript = vim.fn.has("win32") == 1 and { cmd = { "ncat", "localhost", "6005" } } or {},
}

-- -- Setup servers
-- for server, config in pairs(servers) do
-- 	config.on_attach = on_attach
-- 	config.capabilities = capabilities
-- 	lspconfig[server].setup(config)
-- end

-- Defer others
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
	pattern = {
		"*.lua",
		"*.ts",
		"*.js",
		"*.py",
		"*.c",
		"*.cpp",
		"*.dockerfile",
		"*.yaml",
		"*.go",
		"*.html",
		"*.css",
		"*.scss",
		"*.jsx",
		"*.tsx",
		"*.cs",
		"*.java",
		"*.gd",
		"*.rs",
	},
	callback = function(ev)
		vim.cmd("filetype detect")
		local ft = vim.bo[ev.buf].filetype
		local filetype_to_server = {
			lua = "lua_ls",
			typescript = "ts_ls",
			javascript = "ts_ls",
			python = "pyright",
			c = "clangd",
			cpp = "clangd",
			dockerfile = "dockerls",
			yaml = "yamlls",
			go = "gopls",
			html = "html",
			css = "cssls",
			scss = "tailwindcss",
			javascriptreact = "ts_ls",
			typescriptreact = "ts_ls",
			cs = "omnisharp",
			java = "jdtls",
			gdscript = "gdscript",
			rust = "rust_analyzer",
		}
		local server = filetype_to_server[ft]
		if server and servers[server] and server ~= core_server and not lspconfig[server].manager then
			local config = servers[server]
			if server ~= "gdscript" or (server == "gdscript" and vim.fn.executable("ncat") == 1) then
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			elseif server == "gdscript" then
				print("Warning: gdscript not setup - ncat missing (install via 'winget install nmap')")
			end
		end
	end,
})
