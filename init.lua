-- Minimal immediate setup
vim.loader.enable()
vim.opt.shada = "'10,:10,s1"

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

pcall(require, "core.options")
pcall(require, "core.keymaps")
require("lazy").setup("core.configs", {
	performance = {
		rtp = {
			disabled_plugins = { "netrw", "netrwPlugin", "tohtml", "tutor" },
		},
	},
})

vim.opt.updatetime = 250
vim.opt.redrawtime = 1500
