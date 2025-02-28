-- Minimal immediate setup
vim.loader.enable()
vim.opt.shada = ""

-- init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Core settings (minimal)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false -- Reduce I/O
vim.opt.updatetime = 500
vim.opt.redrawtime = 1500

-- Defer all non-critical setup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		pcall(require, "core.options")
		pcall(require, "core.keymaps")
	end,
})

require("lazy").setup("core.configs", {
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = { "netrw", "netrwPlugin", "tohtml", "tutor" },
		},
	},
	defaults = {
		lazy = true,
	},
})

-- Large file optimizations
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local lines = vim.fn.line("$")
		if lines > 10000 then
			vim.b.miniindentscope_disable = true -- Unchanged
			vim.opt_local.syntax = "off" -- Disable Vim syntax (Treesitter still works)
			vim.opt_local.foldmethod = "manual" -- Avoid costly folding
			vim.opt_local.swapfile = false -- No swap for big files
			vim.opt_local.undofile = false -- No undo file
			-- Optional: disable Treesitter/LSP for huge files
			-- vim.cmd("TSBufDisable highlight")
			-- vim.lsp.buf_detach_client(0, vim.lsp.get_active_clients()[1].id)
		end
	end,
})
-- Enable cursorline only in active buffer
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
