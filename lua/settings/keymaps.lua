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

	-- Restart roslyn lsp since it does not have file watching
	map("n", "<leader>l", function()
		local clients = vim.lsp.get_clients()
		for _, client in ipairs(clients) do
			if client.name == "roslyn" or client.name == "roslyn_ls" then
				vim.lsp.stop_client(client.id, true)
			end
		end
		vim.cmd("edit")
	end, { desc = "Restart Roslyn LSP" })

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
	map("n", "<C-z>", "u")
	map("i", "<C-z>", "<C-o>u")

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

	-- LSP keymaps
	local lsp_mappings = {
		["<leader>gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP: Go to Definition",
		},
		["<leader>k"] = {
			function()
				vim.lsp.buf.hover({ border = "single" })
			end,
			"LSP: Hover",
		},
		["<leader>rn"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP: Rename",
		},
		["<leader>gt"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP: Type Definition",
		},
		["<leader>sh"] = {
			function()
				vim.lsp.buf.signature_help({ border = "single" })
			end,
			"LSP: Signature Help",
		},
		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP: Code Action",
		},
		["<leader>d"] = {
			function()
				vim.diagnostic.open_float(nil, {
					source = "always",
					border = "single",
				})
			end,
			"LSP: Show Diagnostic",
		},
	}

	for lhs, config in pairs(lsp_mappings) do
		map("n", lhs, config[1], { desc = config[2], silent = true })
	end
end

return M
