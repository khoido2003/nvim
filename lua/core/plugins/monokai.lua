return {
	{
		"khoido2003/classic_monokai.nvim",
		event = "UIEnter",
		priority = 1000,
		config = function()
			-- Then apply any customizations through on_highlights
			require("classic_monokai").setup({
				plugins = {
					["rainbow-delimiters.nvim"] = true,
					all = true,
				},
				dark_style_background = "default",
				light_style_background = "default",
				hl_styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = { italic = false },
					variables = { italic = false },
					floats = "default",
					sidebars = "default",
				},
				on_highlights = function(highlights, _)
					for _, group in pairs(highlights) do
						if group.italic then
							group.italic = false
						end
					end
				end,
				auto_enable_plugins = true,
				color_headers = true,
				dim_inactive = false,
				lualine_bold = true,
				lualine_style = "default",
				markdown_header_marks = false,
				terminal_colors = true,
				cache = false,
			})
			-- Set the colorscheme first
			vim.cmd.colorscheme("classic-monokai")
		end,
	},
}
