vim.lsp.set_log_level("off") -- Keep off unless debugging

-- vim.o.signcolumn = "auto:2" -- Allow up to 2 sign columns

-- Scrolling and navigation
vim.opt.scrolloff = 5 -- More context, less jittery redraws
vim.opt.sidescrolloff = 5 -- Consistent with scrolloff
vim.opt.sidescroll = 1
vim.opt.mouse = "a" -- Unchanged, minimal cost

-- Text and wrapping
vim.opt.wrap = true
vim.opt.linebreak = true -- Keep for readability
vim.opt.textwidth = 0 -- Disable hard wrapping (let LSP/formatters handle it)
vim.opt.wrapmargin = 0 -- Simplify, reduce redraws
vim.opt.breakindent = true -- Keep for wrapped line readability
vim.opt.inccommand = "split"
vim.opt.showmode = false

-- Editing
vim.opt.backspace = "indent,eol,start"
vim.opt.showcmd = true
vim.opt.laststatus = 2 -- Default, but explicit for clarity
vim.opt.autowrite = true
vim.opt.shiftround = true
vim.opt.swapfile = false -- No swap files, less I/O

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- Consolidated from duplicate

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

vim.diagnostic.config({ virtual_text = true })
