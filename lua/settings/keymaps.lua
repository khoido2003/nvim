local M = {}

-- Common options
local opts = { noremap = true, silent = true }
local no_remap_opts = { noremap = false, silent = true } -- For commands like commenting

-- Close all buffers
vim.api.nvim_create_user_command("BDA", "bufdo bd!", {})

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
	-- map("n", "<Tab>", ":bnext<CR>")
	-- map("n", "<S-Tab>", ":bprev<CR>")

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

	-- Plugin-specific keymaps
	-- NvimTree
	map("n", "<leader>e", ":NvimTreeToggle<CR>")

	-- Telescope
	map("n", "<A-f>", ":Telescope live_grep_args<CR>")
	map("n", "<A-F>", ":Telescope current_buffer_fuzzy_find<CR>")
	map("n", "<leader>fo", ":Telescope oldfiles<CR>")
	map("n", "<leader>fk", ":Telescope keymaps<CR>")
	map("n", "<Tab>", ":Telescope buffers<CR>")
	map("n", "<C-p>", ":Telescope find_files<CR>")

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
