vim.opt.termguicolors = true

vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

vim.lsp.set_log_level("off") -- off/debug

vim.opt.scrolloff = 3
vim.g.loaded_netrw = nil
vim.g.loaded_netrwPlugin = nil
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
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.swapfile = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

--------------------------------------------

-- Rainbow delimiter - monokai
vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f92672" }) -- Slightly lighter pink-red
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9955" }) -- Softer orange
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ffd700" }) -- Muted yellow
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#c3e88d" }) -- Softer lime-green
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#179fff" }) -- Light cyan-blue
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#da70d6" }) -- Softer purple

-------------------------------------------

-- Configure LSP diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})

-- Configure diagnostic signs
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

--///////////////////////////////////

-- Disable indention in large file
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.fn.line("$") > 10000 then -- Disable if file has more than 10,000 lines
			vim.b.miniindentscope_disable = true
		end
	end,
})
