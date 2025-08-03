return {
	"b0o/incline.nvim",
	priority = 1200,
	config = function()
		local helpers = require("incline.helpers")
		local devicons = require("nvim-web-devicons")
		require("incline").setup({
			hide = {
				cursorline = false,
				focused_win = false,
				only_win = false,
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				local bg_color = nil
				local hl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
				if hl.bg then
					bg_color = string.format("#%06x", hl.bg)
				end
				return {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = "bold" },
					modified and { " [+]", gui = "bold", guifg = "#ff5555" } or "",
					" ",
					guibg = bg_color,
				}
			end,
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
		})
	end,
	event = "VeryLazy",
}
