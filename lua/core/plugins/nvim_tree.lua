return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		lazy = true,
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = false,
				update_cwd = false,
				hijack_netrw = false,
				reload_on_bufenter = false,
				filters = { custom = { "node_modules", "__pycache__" } },
				diagnostics = { enable = false },
			})
		end,
	},
}
