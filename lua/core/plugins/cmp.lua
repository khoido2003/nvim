return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions with path info
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions (filesystem)
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Bridge between cmp and LuaSnip
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = {
					{ name = "nvim_lsp" }, -- LSP for types and paths
					{ name = "buffer" }, -- Buffer recommendations
					{ name = "path" }, -- Filesystem paths
					{ name = "luasnip" }, -- Snippets
				},
				formatting = {
					fields = { "kind", "abbr", "menu" }, -- Add "menu" for path details
					format = function(entry, vim_item)
						vim_item.menu = entry:get_completion_item().detail or vim_item.kind
						return vim_item
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
					keyword_length = 2,
				},
			})
		end,
	},
}
