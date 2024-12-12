-- init.lua
vim.opt.termguicolors = true
vim.env.PATH = vim.env.PATH .. ":/c/Users/Lenovo/AppData/Roaming/npm"

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

require("core.plugins")
require("core.options")
require("core.keymaps")
require("core.lsp")
require("core.lsp.cmp")
-- require("core.alpha_c")()
-- require("core.alpha2_c")()
