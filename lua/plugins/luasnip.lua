return {
	"L3MON4D3/LuaSnip",
	event = "VeryLazy",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})
	end,
}
