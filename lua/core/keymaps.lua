-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true })

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- Toggle file tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Search for files with Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })

-- Telescope Mappings
vim.keymap.set("n", "<A-f>", ":Telescope live_grep_args<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-F>", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

-- Copy/paste
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true, silent = true }) -- Copy
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true }) -- Copy in visual mode
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true }) -- Paste
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true }) -- Paste in visual mode
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true }) -- Paste in insert mode
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true }) -- Undo
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true }) -- Undo in insert mode

-- Save the current file
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Delete selected text in Visual Mode
vim.keymap.set("v", "<Del>", '"_d', { noremap = true, silent = true })

-- Select all text in the file
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Start search
vim.keymap.set("n", "<Leader>f", "/", { noremap = true, silent = false })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Move line up/down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Comment
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false, silent = true })
vim.api.nvim_set_keymap("v", "<C-_>", "gc", { noremap = false, silent = true })

-- GitSigns mappings
local gitsigns_mappings = {
	{ "<Leader>rh", ":Gitsigns reset_hunk<CR>" },
	{ "<Leader>rb", ":Gitsigns reset_buffer<CR>" },
	{ "<Leader>ph", ":Gitsigns preview_hunk<CR>" },
	{ "<Leader>df", ":Gitsigns diffthis<CR>" },
	{ "<Leader>bl", ":Gitsigns blame_line<CR>" },
	{ "<Leader>gs", ":Gitsigns toggle_signs<CR>" },
	{ "<Leader>bl", ":Gitsigns toggle_current_line_blame<CR>" },
	{ "<Leader>nh", ":Gitsigns next_hunk<CR>" },
	{ "<Leader>ph", ":Gitsigns prev_hunk<CR>" },
}

for _, mapping in ipairs(gitsigns_mappings) do
	vim.keymap.set("n", mapping[1], mapping[2], { noremap = true, silent = true })
end

-- Normal mode mappings for line navigation
vim.keymap.set("n", "<Down>", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", "gk", { noremap = true, silent = true })

-- Insert mode mappings for line navigation
vim.keymap.set("i", "<Down>", "<C-o>gj", { noremap = true, silent = true })
vim.keymap.set("i", "<Up>", "<C-o>gk", { noremap = true, silent = true })

-- Visual mode mappings for line navigation
vim.keymap.set("v", "<Down>", "gj", { noremap = true, silent = true })
vim.keymap.set("v", "<Up>", "gk", { noremap = true, silent = true })

-- Select the current line with Enter
vim.keymap.set("n", "<CR>", "V", { noremap = true, silent = true })

-- Custom keybinding to create a new terminal easily
vim.api.nvim_set_keymap("n", "<C-t>", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- Git diff view keymap
local opts = { noremap = true, silent = true }

-- Open Diffview to review changes
vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<CR>", opts)

-- Close Diffview
vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<CR>", opts)

-- Refresh Diffview
vim.api.nvim_set_keymap("n", "<leader>dr", ":DiffviewRefresh<CR>", opts)

-- Open File History
vim.api.nvim_set_keymap("n", "<leader>dh", ":DiffviewFileHistory<CR>", opts)

-- Open File History for current file
vim.api.nvim_set_keymap("n", "<leader>dhf", ":DiffviewFileHistory %<CR>", opts)

-- Undo changes in the working tree type :e!

--       { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
--       { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
--       { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
--       { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
--       { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
--       { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
--       { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
--       { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
--       { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
--       { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
