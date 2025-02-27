-- Core settings
vim.opt.termguicolors = true
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.lsp.set_log_level("off") -- Keep off unless debugging

-- Scrolling and navigation
vim.opt.scrolloff = 5 -- More context, less jittery redraws
vim.opt.sidescrolloff = 5 -- Consistent with scrolloff
vim.opt.sidescroll = 1
vim.opt.mouse = "a" -- Unchanged, minimal cost

-- Disable netrw (unchanged)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Text and wrapping
vim.opt.wrap = true
vim.opt.linebreak = true -- Keep for readability
vim.opt.textwidth = 0 -- Disable hard wrapping (let LSP/formatters handle it)
vim.opt.wrapmargin = 0 -- Simplify, reduce redraws
vim.opt.breakindent = true -- Keep for wrapped line readability

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

-- Performance tweaks
vim.opt.cursorline = false -- Disable by default, enable selectively

-- Rainbow delimiters (unchanged, minimal cost)
vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f92672" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9955" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ffd700" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#c3e88d" })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#179fff" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#da70d6" })

-- LSP diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		source = "if_many", -- Only show if multiple diagnostics, reduces clutter
		update_in_insert = false, -- Unchanged, avoids insert-mode redraws
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	float = { border = "rounded" }, -- Optional: cleaner popup look
})

-- Diagnostic signs (unchanged, lightweight)
local signs = {
	{ name = "Error", text = "E" },
	{ name = "Warn", text = "W" },
	{ name = "Hint", text = "H" },
	{ name = "Info", text = "I" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. sign.name, {
		text = sign.text,
		texthl = "Diagnostic" .. sign.name,
	})
end

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
