vim.loader.enable()
vim.opt.shada = ""

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.schedule(function()
			require("core.options")
			require("core.keymaps").setup()
		end)
	end,
})

require("lazy").setup("core.configs", {
	performance = {
		cache = { enabled = true },
		rtp = {
			reset = false,
			disabled_plugins = {
				"netrw",
				"netrwPlugin",
				"tohtml",
				"tutor",
				"gzip",
				"zipPlugin",
				"tarPlugin",
				"matchit",
				"perl_provider",
				"ruby_provider",
				"node_provider",
			},
		},
	},
})

vim.opt.termguicolors = true
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.redrawtime = 1500

vim.g.loaded_matchparen = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_shada = 1
vim.g.loaded_spellfile = 1

-- Large file optimizations
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local lines = vim.fn.line("$")
		if lines > 15000 then
			vim.opt_local.syntax = "off"
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
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
