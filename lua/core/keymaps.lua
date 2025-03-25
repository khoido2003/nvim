local M = {}

-- Common options
local opts = { noremap = true, silent = true }
local no_remap_opts = { noremap = false, silent = true } -- For commands like commenting

-- Helper function to set keymaps
local function map(mode, lhs, rhs, options)
	vim.keymap.set(mode, lhs, rhs, options or opts)
end

-- Setup function to be called lazily
function M.setup()
	-- Pane navigation
	local pane_mappings = {
		["<C-h>"] = ":wincmd h<CR>",
		["<C-j>"] = ":wincmd j<CR>",
		["<C-k>"] = ":wincmd k<CR>",
		["<C-l>"] = ":wincmd l<CR>",
	}
	for lhs, rhs in pairs(pane_mappings) do
		map("n", lhs, rhs)
	end

	-- General editing
	map("n", "<leader>h", ":nohlsearch<CR>") -- Clear search highlight
	map("n", "<C-s>", ":w<CR>") -- Save file
	map("n", "<C-a>", "ggVG") -- Select all

	-- Copy/paste with system clipboard
	map("n", "<C-c>", '"+y')
	map("v", "<C-c>", '"+y')
	map("n", "<C-v>", '"+p')
	map("v", "<C-v>", '"+p')
	map("i", "<C-v>", "<C-r>+")
	map("n", "<C-z>", "u") -- Undo in normal mode
	map("i", "<C-z>", "<C-o>u") -- Undo in insert mode

	-- Buffer navigation
	map("n", "<Tab>", ":bnext<CR>")
	map("n", "<S-Tab>", ":bprev<CR>")

	-- Move lines
	map("n", "<A-k>", ":m .-2<CR>==")
	map("n", "<A-j>", ":m .+1<CR>==")

	-- Line navigation (wrapped lines)
	for _, mode in ipairs({ "n", "v" }) do
		map(mode, "<Down>", "gj")
		map(mode, "<Up>", "gk")
	end
	map("i", "<Down>", "<C-o>gj")
	map("i", "<Up>", "<C-o>gk")

	-- Select current line
	map("n", "<CR>", "V")

	-- Commenting
	map("n", "<C-_>", "gcc", no_remap_opts)
	map("v", "<C-_>", "gc", no_remap_opts)

	-- Plugin-specific keymaps
	-- NvimTree
	map("n", "<leader>e", ":NvimTreeToggle<CR>")

	-- Telescope
	map("n", "<leader>ff", ":Telescope find_files<CR>")
	map("n", "<A-f>", ":Telescope live_grep_args<CR>")
	map("n", "<A-F>", ":Telescope current_buffer_fuzzy_find<CR>")

	-- Gitsigns
	local gitsigns_mappings = {
		["<Leader>rh"] = ":Gitsigns reset_hunk<CR>",
		["<Leader>rb"] = ":Gitsigns reset_buffer<CR>",
		["<Leader>ph"] = ":Gitsigns preview_hunk<CR>",
		["<Leader>df"] = ":Gitsigns diffthis<CR>",
		["<Leader>bl"] = ":Gitsigns blame_line<CR>",
		["<Leader>gs"] = ":Gitsigns toggle_signs<CR>",
		["<Leader>tl"] = ":Gitsigns toggle_current_line_blame<CR>",
		["<Leader>nh"] = ":Gitsigns next_hunk<CR>",
		["<Leader>pv"] = ":Gitsigns prev_hunk<CR>",
	}
	for lhs, rhs in pairs(gitsigns_mappings) do
		map("n", lhs, rhs)
	end

	-- Diffview
	local diffview_mappings = {
		["<leader>do"] = ":DiffviewOpen<CR>",
		["<leader>dc"] = ":DiffviewClose<CR>",
		["<leader>dr"] = ":DiffviewRefresh<CR>",
		["<leader>dh"] = ":DiffviewFileHistory<CR>",
		["<leader>dhf"] = ":DiffviewFileHistory %<CR>",
	}
	for lhs, rhs in pairs(diffview_mappings) do
		map("n", lhs, rhs)
	end
end

return M
