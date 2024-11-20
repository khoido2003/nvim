-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clear search highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Toggle file tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Search for files with Telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')

-- LSP: Go to Definition
vim.api.nvim_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- LSP: Show Documentation (Hover)
vim.api.nvim_set_keymap('n', '<leader>k', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- LSP: Rename Symbol
vim.api.nvim_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

-- LSP: Find References
vim.api.nvim_set_keymap('n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

-- LSP: Trigger Completion (for cmp or any other LSP-based completion)
vim.keymap.set('i', '<C-Space>', function()
  require('cmp').complete()
end, { noremap = true, silent = true })

-- LSP: Go to Type Definition
vim.api.nvim_set_keymap('n', '<leader>gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })

-- LSP: Show Signature Help
vim.api.nvim_set_keymap('n', '<leader>sh', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

-- LSP: Format Document
vim.api.nvim_set_keymap('n', '<leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })

-- LSP: Code Action (Quickfix)
vim.api.nvim_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

-- Set the keybinding for Ctrl+Shift+F to launch Telescope live_grep
vim.api.nvim_set_keymap('n', '<C-S-f>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Keybinding for opening vim-spectre
vim.api.nvim_set_keymap('n', '<C-S-R>', ':Spectre<CR>', { noremap = true, silent = true })


-- Keymaps for VS Code-style shortcuts
vim.keymap.set('n', '<C-c>', '"+y', { noremap = true, silent = true }) -- Copy
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Copy in visual mode
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste
vim.keymap.set('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste in visual mode
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true }) -- Paste in insert mode
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true }) -- Undo
vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, silent = true }) -- Undo in insert mode

-- Mapping Ctrl+S to save the current file
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Map the Delete key in Visual Mode to delete selected text
vim.api.nvim_set_keymap('v', '<Del>', '"_d', { noremap = true, silent = true })

-- Map Ctrl+A to select all text in the file
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

-- Pressing <Leader>f will start search
vim.api.nvim_set_keymap('n', '<Leader>f', '/', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.g.VM_maps = {
  ["Find Under"] = "<C-d>", -- Key to find and select occurrences
  ["Add Cursor Down"] = "<C-Down>", -- Add a cursor down
  ["Add Cursor Up"] = "<C-Up>", -- Add a cursor up
}