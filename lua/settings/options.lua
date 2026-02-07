vim.opt.termguicolors = true
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.redrawtime = 1500

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.g.loaded_matchparen = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_shada = 1
vim.g.loaded_spellfile = 1

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.sidescroll = 1
vim.opt.mouse = "a"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.breakindent = true
vim.opt.inccommand = "split"
vim.opt.showmode = false

vim.opt.backspace = "indent,eol,start"
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.shiftround = true
vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.lsp.set_log_level("off")
vim.diagnostic.config({ virtual_text = true })

if vim.fn.has("win32") == 1 then
	vim.o.shell = "pwsh.exe"
	vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
	vim.o.shellpipe = ">"
	vim.o.shellredir = ">"
else
	vim.o.shell = "zsh"
	vim.o.shellcmdflag = "-c"
end
