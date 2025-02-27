return {
	"polirritmico/monokai-nightasty.nvim",
	lazy = true,
	event = "UIEnter",
	priority = 1000,
	config = function()
		require("monokai-nightasty").setup({
			dark_style_background = "default", -- default, dark, transparent, #RRGGBB
			light_style_background = "default", -- default, dark, transparent, #RRGGBB
			hl_styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = { italic = false },
				variables = { italic = false },

				floats = "default", -- default, dark, transparent
				sidebars = "default", -- default, dark, transparent
			},

			on_highlights = function(highlights, _)
				-- Disable bold and italic for various elements
				for _, group in pairs(highlights) do
					if group.italic then
						group.italic = false
					end
					if group.bold then
						group.bold = false
					end
				end
			end,
			color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
			dim_inactive = false,
			lualine_bold = true,
			lualine_style = "default", -- "dark", "light" or "default" (default follows dark/light style)

			markdown_header_marks = true,
			terminal_colors = true,
			cache = true,
			auto_enable_plugins = true,
		})
		require("monokai-nightasty").load()
		vim.cmd.colorscheme("monokai-nightasty")
	end,
}
