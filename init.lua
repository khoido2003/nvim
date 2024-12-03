-- init.lua
vim.env.PATH = vim.env.PATH .. ':/c/Users/Lenovo/AppData/Roaming/npm'

-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap('i', '<Down>', '<C-o>gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Up>', '<C-o>gk', { noremap = true, silent = true })

-- Visual mode mappings
vim.api.nvim_set_keymap('v', '<Down>', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Up>', 'gk', { noremap = true, silent = true })


vim.o.scrolloff = 3  -- Keep 3 lines visible above and below the cursor

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.lsp")  
require('core.lsp.cmp') 



