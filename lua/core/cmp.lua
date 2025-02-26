local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- Unchanged, lightweight
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
		{ name = "nvim_lsp", priority = 1000 }, -- High priority for LSP
		{ name = "luasnip", priority = 750 }, -- Snippets next
		{ name = "path", priority = 500 }, -- Paths lower
		{ name = "buffer", priority = 250, keyword_length = 3 }, -- Buffer only after 3 chars
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- Just icons, no text (faster)
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
		debounce = 50, -- Delay before showing completions (ms)
		throttle = 30, -- Delay between updates (ms)
		max_view_entries = 10, -- Cap visible entries
	},
})

-- Optional: Disable in large files
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.fn.line("$") > 20000 then
			cmp.setup.buffer({ enabled = false })
		end
	end,
})
