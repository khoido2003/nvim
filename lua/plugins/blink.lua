return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = {},
	version = "1.*",
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				--    window = { border = "single" }
			},
			menu = {
				--    border = "single"
			},
		},
		sources = {
			default = { "lsp", "path", "buffer" },
		},
		signature = {
			enabled = true,
			--    window = { border = "single" }
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
