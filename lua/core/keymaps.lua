-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Toggle file tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Search for files with Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")

-- LSP: Go to Definition
vim.api.nvim_set_keymap("n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- LSP: Show Documentation (Hover)
vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- LSP: Rename Symbol
vim.api.nvim_set_keymap("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

-- LSP: Find References
vim.api.nvim_set_keymap("n", "<leader>gr", "<Cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })

-- LSP: Trigger Completion (for cmp or any other LSP-based completion)
vim.keymap.set("i", "<C-Space>", function()
	require("cmp").complete()
end, { noremap = true, silent = true })

-- LSP: Go to Type Definition
vim.api.nvim_set_keymap(
	"n",
	"<leader>gt",
	"<Cmd>lua vim.lsp.buf.type_definition()<CR>",
	{ noremap = true, silent = true }
)

-- LSP: Show Signature Help
vim.api.nvim_set_keymap(
	"n",
	"<leader>sh",
	"<Cmd>lua vim.lsp.buf.signature_help()<CR>",
	{ noremap = true, silent = true }
)

-- LSP: Format Document
vim.api.nvim_set_keymap("n", "<leader>lf", "<Cmd>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })

-- LSP: Code Action (Quickfix)
vim.api.nvim_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- Set the keybinding for Ctrl+Shift+F to launch Telescope live_grep

vim.api.nvim_set_keymap("n", "<A-f>", ":Telescope live_grep_args<CR>", { noremap = true, silent = true })

-- Keybinding to search within the current file (using Telescope's fuzzy search)
vim.api.nvim_set_keymap("n", "<A-F>", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

-- Keybinding for opening vim-spectre
vim.api.nvim_set_keymap("n", "<leader>rp", ":Spectre<CR>", { noremap = true, silent = true })

-- Keymaps for VS Code-style shortcuts
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true, silent = true }) -- Copy
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true }) -- Copy in visual mode
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true }) -- Paste
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true }) -- Paste in visual mode
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true }) -- Paste in insert mode
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true }) -- Undo
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true }) -- Undo in insert mode

-- Mapping Ctrl+S to save the current file
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Map the Delete key in Visual Mode to delete selected text
vim.api.nvim_set_keymap("v", "<Del>", '"_d', { noremap = true, silent = true })

-- Map Ctrl+A to select all text in the file
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Pressing <Leader>f will start search
vim.api.nvim_set_keymap("n", "<Leader>f", "/", { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.g.VM_maps = {
	["Find Under"] = "<C-d>", -- Key to find and select occurrences
	["Add Cursor Down"] = "<C-Down>", -- Add a cursor down
	["Add Cursor Up"] = "<C-Up>", -- Add a cursor up
}

-- Keybinding to open diagnostics in a floating window
vim.api.nvim_set_keymap("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("R", function()
	vim.cmd("wa") -- Save all files
	vim.cmd('silent! exec "!kill -USR1 $(pgrep -f nvim)"')
end, { desc = "Restart Neovim" })

vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- Move line up
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
-- Move line down
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Comment
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false, silent = true })
vim.api.nvim_set_keymap("v", "<C-_>", "gc", { noremap = false, silent = true })

-- Reset hunk (Undo changes in the current hunk)
vim.api.nvim_set_keymap("n", "<Leader>rh", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })

-- Reset buffer (Undo changes in the entire file)
vim.api.nvim_set_keymap("n", "<Leader>rb", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true })

-- Preview current hunk
vim.api.nvim_set_keymap("n", "<Leader>ph", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true })

-- Diff current file
vim.api.nvim_set_keymap("n", "<Leader>df", ":Gitsigns diffthis<CR>", { noremap = true, silent = true })

-- Blame current line
vim.api.nvim_set_keymap("n", "<Leader>bl", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })

-- Toggle GitSigns
vim.api.nvim_set_keymap("n", "<Leader>gs", ":Gitsigns toggle_signs<CR>", { noremap = true, silent = true })

-- Toggle line blame
vim.api.nvim_set_keymap("n", "<Leader>bl", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true })

-- Next hunk
vim.api.nvim_set_keymap("n", "<Leader>nh", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })

-- Previous hunk
vim.api.nvim_set_keymap("n", "<Leader>ph", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })

-- Togge paste/no paste mode with F2
vim.api.nvim_set_keymap("n", "<F2>", ":set paste!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-m>", "V", { noremap = true, silent = true })

--Normal mode mappings
vim.api.nvim_set_keymap("n", "<Down>", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Up>", "gk", { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap("i", "<Down>", "<C-o>gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Up>", "<C-o>gk", { noremap = true, silent = true })

-- Visual mode mappings
vim.api.nvim_set_keymap("v", "<Down>", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Up>", "gk", { noremap = true, silent = true })
