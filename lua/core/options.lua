--  options.lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable line wrapping
vim.o.wrap = true

-- Wrap at word boundaries
vim.o.linebreak = true

-- Set the margin for wrapping
vim.o.textwidth = 80
vim.o.wrapmargin = 2

-- Indent wrapped lines
vim.o.breakindent = true

-- Disable horizontal scrolling
vim.o.sidescrolloff = 0
vim.o.sidescroll = 1


vim.opt.backspace = '2'
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

vim.cmd [[ set noswapfile ]]
vim.cmd [[ set termguicolors ]]

--Line numbers
vim.wo.number = true

-- gruvbox_config.lua
vim.o.background = "dark"  -- Set background to dark
vim.g.gruvbox_contrast_dark = "hard"  -- Set the dark hard contrast

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    vim.cmd("colorscheme gruvbox")
  end,
})


-- Enable line wrapping globally
vim.o.wrap = true
vim.o.linebreak = true

-- Configure LSP diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",   -- You can change the icon for inline diagnostics
    spacing = 2,     -- Control the spacing between text and diagnostic
  },
  signs = true,        -- Enable sign column for diagnostics
  underline = true,    -- Underline lines with diagnostics
  update_in_insert = true,  -- Update diagnostics even in insert mode
})

-- Configure diagnostic signs (optional customization)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type })
end

-- Ensure LSP floating windows don't overflow
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  wrap = true,
  border = "rounded",  -- Rounded border for better readability
  max_width = 80,      -- Optionally limit width for floating windows
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  wrap = true,
  border = "rounded",
  max_width = 80,
})
