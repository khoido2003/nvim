return {
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = true },
			{ "hrsh7th/cmp-buffer", lazy = true },
			{ "hrsh7th/cmp-path", lazy = true },
			{
				"hrsh7th/cmp-nvim-lsp-signature-help",
				lazy = true,
			},
			{ "onsails/lspkind-nvim", lazy = true },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				window = {
					documentation = {
						max_width = 80,
						max_height = 20,
					},
				},

				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						ellipsis_char = "...",
						menu = {
							buffer = "[BUF]",
							nvim_lsp = "[LSP]",
							path = "[PATH]",
							nvim_lsp_signature_help = "[SIG]",
						},
					}),
				},

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lsp_signature_help" },
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				performance = {
					debounce = 20,
					throttle = 5,
					max_view_entries = 12,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})
		end,
	},
}
