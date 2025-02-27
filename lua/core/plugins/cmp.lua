return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- Manual trigger
					["<C-e>"] = cmp.mapping.abort(), -- Close menu (faster than close())
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback() -- Normal Tab if no completion
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback() -- Normal S-Tab if no completion
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "path", priority = 500 },
					{ name = "buffer", priority = 250, keyword_length = 3 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "text", -- Just icons, no text (faster)
						maxwidth = 50,
						before = function(entry, vim_item)
							vim_item.menu = nil -- Remove menu text to lighten redraw
							return vim_item
						end,
					}),
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
					keyword_length = 2, -- Trigger after 2 chars, less aggressive
					max_item_count = 10, -- Fewer items, faster rendering
				},
				performance = {
					debounce = 30, -- Delay before showing completions (ms)
					throttle = 20, -- Delay between updates (ms)
					max_view_entries = 10, -- Cap visible entries
				},
				experimental = {
					ghost_text = false, -- Disable if it causes lag
				},
			})

			-- Export capabilities for lsp.lua
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			vim.g.cmp_capabilities = capabilities
		end,
	},
}
