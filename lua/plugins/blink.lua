return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = "1.*",
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "mono",
		},
		snippets = {
			preset = "luasnip",
		},
		completion = {
			documentation = {
				auto_show = true,
			},
			menu = {},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				snippets = {
					min_keyword_length = 2, -- don't show snippets on 1 char
					score_offset = 10,
				},
			},
		},
		signature = {
			enabled = true,
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
