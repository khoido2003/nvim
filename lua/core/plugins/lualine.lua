return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPost",

		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = " ",
					section_separators = { left = "", right = "" },
					refresh = { statusline = 102, tabline = 102, winbar = 102 },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diagnostics" },
					lualine_c = { { "filename", path = 0 } },
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
