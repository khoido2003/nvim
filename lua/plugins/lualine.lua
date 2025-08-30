return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
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
				lualine_a = {
					{
						function()
							local mode = vim.api.nvim_get_mode().mode
							local mode_map = {
								n = "N",
								no = "N",
								nov = "N",
								niI = "N",
								niR = "N",
								niV = "N",
								nt = "N",
								v = "V",
								vs = "V",
								V = "V",
								Vs = "V",
								[""] = "V",
								s = "S",
								S = "S",
								[""] = "S",
								i = "I",
								ic = "I",
								ix = "I",
								R = "R",
								Rc = "R",
								Rx = "R",
								Rv = "R",
								c = "C",
								cv = "C",
								ce = "C",
								r = "R",
								rm = "M",
								["r?"] = "?",
								["!"] = "!",
								t = "T",
							}
							return mode_map[mode] or mode:sub(1, 1):upper()
						end,
						color = { gui = "bold" },
					},
				},

				lualine_b = {},

				lualine_c = {
					{
						function()
							local filename = vim.fn.expand("%:t")
							local file_status = ""
							if vim.bo.modified then
								file_status = file_status .. " ●"
							end
							if vim.bo.readonly then
								file_status = file_status .. " "
							end
							if filename == "" then
								return "[No Name]"
							end

							return filename .. file_status
						end,
						icon = "",
					},
				},

				lualine_x = {
					{
						"diff",
						cond = function()
							return vim.fn.winwidth(0) > 40
						end,
					},
					{
						"diagnostics",
						cond = function()
							return vim.fn.winwidth(0) > 40
						end,
					},
					{
						function()
							local filename = vim.fn.expand("%:t")
							local extension = vim.fn.expand("%:e")
							local icon = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
								or ""

							local bufnr = vim.api.nvim_get_current_buf()
							local clients = vim.lsp.get_clients({ bufnr = bufnr })

							if #clients == 0 then
								return icon .. " no LSP"
							end
							return icon .. " LSP"
						end,
						cond = function()
							return vim.fn.winwidth(0) > 60
						end,
					},
				},
				lualine_y = {},
				lualine_z = { "branch" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "progress" },
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
