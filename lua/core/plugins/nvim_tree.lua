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
				filters = { custom = { ".git", "node_modules", "__pycache__" }, git_ignored = false },
				diagnostics = { enable = false },
			})
		end,
	},
}
