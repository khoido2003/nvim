vim.opt.termguicolors = true

vim.opt.guifont = "Fira Code:h12"
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

vim.lsp.set_log_level("off") -- off/debug

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
vim.opt.backspace = "indent,eol,start"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.swapfile = false

-- Line numbers
vim.opt.relativenumber = true
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
})

-- Configure diagnostic signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type })
end

-- Keybinding for commenting a line with Ctrl + /
vim.api.nvim_set_keymap(
	"n",
	"<C-/>",
	":lua require('Comment.api').toggle.linewise.current()<CR>",
	{ noremap = true, silent = true }
)

vim.lsp.handlers["textDocument/semanticTokens/full"] =
	vim.lsp.with(vim.lsp.handlers.semantic_tokens, { highlight = true })
