--  options.lua

-- vim.cmd([[colorscheme carbonfox]])
vim.cmd([[colorscheme vscode]])
----------------------------------------------------------

vim.opt.guifont = "Fira Code:h12"

vim.o.fileencoding = "utf-8"
vim.o.encoding = "utf-8"

vim.lsp.set_log_level("debug")

vim.o.scrolloff = 3 -- Keep 3 lines visible above and below the cursor

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.o.wrap = true -- Enable line wrapping
vim.o.linebreak = true -- Wrap at word boundaries
vim.o.textwidth = 80 -- Set text width for automatic wrapping
vim.o.wrapmargin = 2 -- Set the margin for wrapping
vim.o.breakindent = true -- Indent wrapped lines
vim.o.sidescrolloff = 0 -- Disable horizontal scrolling
vim.o.sidescroll = 1 -- Set minimal horizontal scroll

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 5
vim.opt.mouse = "a" -- Enable mouse in all modes

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd([[ set noswapfile ]])
vim.cmd([[ set termguicolors ]])

--Line numbers
-- vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.number = true

-- Enable line wrapping globally
vim.o.wrap = true
vim.o.linebreak = true

-- Configure LSP diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- You can change the icon for inline diagnostics
		spacing = 2, -- Control the spacing between text and diagnostic,
		wrap = true,
	},
	signs = true, -- Enable sign column for diagnostics (icons in the gutter)
	underline = true, -- Underline lines with diagnostics
	update_in_insert = true, -- Update diagnostics even in insert mode
	float = { -- Disable floating window diagnostics
		enabled = false, -- Ensure floating windows are not shown for diagnostics
		max_width = 80, -- Adjust the max width of the floating diagnostic window
		wrap = true, -- Ensure diagnostics wrap within the floating window
	},
})

-- Ensure no other floating windows are shown
vim.lsp.handlers["textDocument/hover"] = function() end -- Disable hover floating window
vim.lsp.handlers["textDocument/signatureHelp"] = function() end -- Disable signature help window

-- Configure diagnostic signs (optional customization)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type })
end

vim.cmd([[
  highlight DiagnosticError guibg=NONE 
  highlight DiagnosticWarn guibg=NONE 
  highlight DiagnosticInfo guibg=NONE
  highlight DiagnosticHint guibg=NONE 
]])

-- Format code automatically on save for C#
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.cs", -- Only for C# files
	callback = function()
		-- Request formatting from the LSP
		vim.lsp.buf.format({ async = true }) -- Format asynchronously
	end,
})

-- Keybinding for commenting a line with Ctrl + /
vim.api.nvim_set_keymap(
	"n",
	"<C-/>",
	":lua require('Comment.api').toggle.linewise.current()<CR>",
	{ noremap = true, silent = true }
)

vim.o.termguicolors = true -- Ensure true color support
vim.lsp.handlers["textDocument/semanticTokens/full"] =
	vim.lsp.with(vim.lsp.handlers.semantic_tokens, { highlight = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.cs",
	callback = function()
		vim.cmd("LspRestart") -- Automatically restart the language server
	end,
})

-- Add Dockerfile filetype detection
vim.cmd("autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile")

-- Set filetype for Kubernetes and Docker-related YAML files
vim.cmd("autocmd BufNewFile,BufRead *.yaml set filetype=yaml")
vim.cmd("autocmd BufNewFile,BufRead *.yml set filetype=yaml")

-- Restart Roslyn LSP when create new C# file
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	pattern = "*.cs",
	callback = function()
		-- Restart Roslyn LSP server automatically
		vim.cmd("Roslyn restart")
	end,
})

vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx, config)
	if not result or vim.tbl_isempty(result) then
		return
	end
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client and result[1] then
		local target_uri = result[1].uri
		local target_range = result[1].range
		local target_bufnr = vim.uri_to_bufnr(target_uri)

		if target_bufnr == vim.api.nvim_get_current_buf() then
			-- Only jump if the target buffer is the current buffer
			vim.api.nvim_win_set_cursor(0, { target_range.start.line + 1, target_range.start.character })
		else
			vim.lsp.util.jump_to_location(result[1])
		end
	end
end

-- ////////////////////////////////////////

-- Rust
vim.g.rustaceanvim = {
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- Keymaps for LSP actions
			print("LSP Attached!")

			-- Use Space + gd to go to definition
			vim.keymap.set("n", "<Space>gd", function()
				vim.lsp.buf.definition()
			end, { buffer = bufnr, silent = true })

			vim.keymap.set("n", "<C-C> <C-A>", function()
				vim.lsp.buf.code_action()
			end, { buffer = bufnr, silent = true })

			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, { buffer = bufnr, silent = true })

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, { buffer = bufnr, silent = true })
		end,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
	-- Tools configuration (optional)
	tools = {
		rustfmt = true, -- Enable rustfmt for automatic formatting
		clippy = true, -- Enable clippy for linting
	},
}
