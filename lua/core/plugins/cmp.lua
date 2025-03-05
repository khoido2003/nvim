return {
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = true }, -- LSP completions with path info
			{ "hrsh7th/cmp-buffer", lazy = true }, -- Buffer completions
			{ "hrsh7th/cmp-path", lazy = true }, -- Path completions (filesystem)
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
					["<C-e>"] = cmp.mapping.close(), -- Close completion menu
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
					["<Tab>"] = cmp.mapping.select_next_item(), -- Select next item
					["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Select previous item
				}),
				sources = {
					{ name = "nvim_lsp" }, -- LSP completion source
					{ name = "path" }, -- Path completion source
					{ name = "buffer" }, -- Buffer completion source
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})
		end,
	},
}
