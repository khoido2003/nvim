--  options.lua
vim.opt.guifont = "Fira Code:h13"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General settings
vim.o.wrap = true               -- Enable line wrapping
vim.o.linebreak = true          -- Wrap at word boundaries
vim.o.textwidth = 80            -- Set text width for automatic wrapping
vim.o.wrapmargin = 2           -- Set the margin for wrapping
vim.o.breakindent = true       -- Indent wrapped lines
vim.o.sidescrolloff = 0        -- Disable horizontal scrolling
vim.o.sidescroll = 1           -- Set minimal horizontal scroll

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 5
vim.opt.mouse = "a" -- Enable mouse in all modes

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
    vim.cmd("colorscheme kanagawa")
  end,
})   

-- Enable line wrapping globally
vim.o.wrap = true
vim.o.linebreak = true 

-- Configure LSP diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",   -- You can change the icon for inline diagnostics
    spacing = 2,     -- Control the spacing between text and diagnostic,
    wrap = true,
  },
  signs = true,        -- Enable sign column for diagnostics (icons in the gutter)
  underline = true,    -- Underline lines with diagnostics
  update_in_insert = true,  -- Update diagnostics even in insert mode
  float = {            -- Disable floating window diagnostics
    enabled = false,   -- Ensure floating windows are not shown for diagnostics
    max_width = 80,   -- Adjust the max width of the floating diagnostic window
    wrap = true,      -- Ensure diagnostics wrap within the floating window
  }
})

-- Ensure no other floating windows are shown
vim.lsp.handlers["textDocument/hover"] = function() end  -- Disable hover floating window
vim.lsp.handlers["textDocument/signatureHelp"] = function() end  -- Disable signature help window

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
  pattern = "*.cs",  -- Only for C# files
  callback = function()
    -- Request formatting from the LSP
    vim.lsp.buf.format({ async = true })  -- Format asynchronously
  end,
})


-- Keybinding for commenting a line with Ctrl + /
vim.api.nvim_set_keymap("n", "<C-/>", ":lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true })


-- Disable italics in comments and diagnostics
vim.api.nvim_set_hl(0, 'Comment', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { italic = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { italic = false })

vim.cmd [[
  highlight clear Comment
  highlight clear DiagnosticVirtualTextError
  highlight clear DiagnosticVirtualTextWarn
  highlight clear DiagnosticVirtualTextInfo
  highlight clear DiagnosticVirtualTextHint
  highlight clear DiagnosticUnderlineError
  highlight clear DiagnosticUnderlineWarn
  highlight clear DiagnosticUnderlineInfo
  highlight clear DiagnosticUnderlineHint
]]

vim.o.termguicolors = true -- Ensure true color support
vim.lsp.handlers["textDocument/semanticTokens/full"] = vim.lsp.with(
  vim.lsp.handlers.semantic_tokens,
  { highlight = true }
)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.cs",
  callback = function()
      vim.cmd('LspRestart') -- Automatically restart the language server
  end,
})
