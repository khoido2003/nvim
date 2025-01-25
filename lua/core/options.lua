vim.cmd([[colorscheme vscode]])

vim.opt.guifont = "Fira Code:h12"
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.lsp.set_log_level("debug")

vim.opt.scrolloff = 3
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 80
vim.opt.wrapmargin = 2
vim.opt.breakindent = true
vim.opt.sidescrolloff = 0
vim.opt.sidescroll = 1
vim.opt.mouse = "a"
vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.cmd([[set noswapfile]])
vim.cmd([[set termguicolors]])

-- Line numbers
vim.wo.relativenumber = true
vim.opt.number = true

-- Configure LSP diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	float = {
		enabled = false,
		max_width = 80,
	},
})

-- Disable floating windows for hover and signature help
vim.lsp.handlers["textDocument/hover"] = function() end
vim.lsp.handlers["textDocument/signatureHelp"] = function() end

-- Configure diagnostic signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type })
end

vim.cmd([[
  highlight DiagnosticError guibg=NONE 
  highlight DiagnosticWarn guibg=NONE 
  highlight DiagnosticInfo guibg=NONE
  highlight DiagnosticHint guibg=NONE 
]])

-- Format code automatically on save for C#
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.cs",
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

-- Keybinding for commenting a line with Ctrl + /
vim.api.nvim_set_keymap(
	"n",
	"<C-/>",
	":lua require('Comment.api').toggle.linewise.current()<CR>",
	{ noremap = true, silent = true }
)

vim.o.termguicolors = true
vim.lsp.handlers["textDocument/semanticTokens/full"] =
	vim.lsp.with(vim.lsp.handlers.semantic_tokens, { highlight = true })

-- Restart Roslyn LSP when creating a new C# file
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	pattern = "*.cs",
	callback = function()
		vim.cmd("Roslyn restart")
	end,
})

-- Add Dockerfile filetype detection
vim.cmd("autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile")

-- Set filetype for Kubernetes and Docker-related YAML files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.yaml", "*.yml" },
	command = "set filetype=yaml",
})
