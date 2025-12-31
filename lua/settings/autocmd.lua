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

vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function()
		if vim.fn.line("$") > 15000 then
			vim.cmd("TSBufDisable highlight")
		end
	end,
})
