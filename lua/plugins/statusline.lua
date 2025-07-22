return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",

	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = { "NvimTree", "TelescopePrompt" },
				always_divide_middle = true,
				always_show_tabline = false,
				globalstatus = false,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "" },
				lualine_x = {
					{
						function()
							local bufnr = vim.api.nvim_get_current_buf()
							local clients = vim.lsp.get_clients({ bufnr = bufnr })
							if #clients == 0 then
								return " no LSP"
							end
							return " " .. clients[1].name
						end,
						icon = "",
					},
					"encoding",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
