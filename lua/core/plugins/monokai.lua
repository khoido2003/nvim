return {
	{
		"khoido2003/classic_monokai.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Then apply any customizations through on_highlights
			require("classic_monokai").setup({
				dark_style_background = "default",
				light_style_background = "default",
				hl_styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = { italic = false },
					variables = { italic = false },
					floats = "dark",
					sidebars = "dark",
				},
				on_highlights = function(highlights, _)
					for _, group in pairs(highlights) do
						if group.italic then
							group.italic = false
						end
						if group.bold then
							group.bold = false
						end
					end
				end,
				auto_enable_plugins = true,
				plugins = { all = true },
				color_headers = true,
				dim_inactive = false,
				lualine_bold = true,
				lualine_style = "default",
				markdown_header_marks = false,
				terminal_colors = true,
				cache = true,
			})

			-- Set the colorscheme first
			vim.cmd.colorscheme("classic-monokai")
		end,
	},

	-- {
	-- 	"polirritmico/monokai-nightasty.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("monokai-nightasty").setup({
	-- 			dark_style_background = "default", -- default, dark, transparent, #RRGGBB
	-- 			light_style_background = "default", -- default, dark, transparent, #RRGGBB
	-- 			hl_styles = {
	-- 				comments = { italic = false },
	-- 				keywords = { italic = false },
	-- 				functions = { italic = false },
	-- 				variables = { italic = false },
	--
	-- 				floats = "default", -- default, dark, transparent
	-- 				sidebars = "default", -- default, dark, transparent
	-- 			},
	--
	-- 			on_highlights = function(highlights, _)
	-- 				-- Disable bold and italic for various elements
	-- 				for _, group in pairs(highlights) do
	-- 					if group.italic then
	-- 						group.italic = false
	-- 					end
	-- 					if group.bold then
	-- 						group.bold = false
	-- 					end
	-- 				end
	-- 			end,
	-- 			color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
	-- 			dim_inactive = false,
	-- 			lualine_bold = true,
	-- 			lualine_style = "default", -- "dark", "light" or "default" (default follows dark/light style)
	--
	-- 			markdown_header_marks = false,
	-- 			terminal_colors = true,
	-- 			cache = true,
	-- 			auto_enable_plugins = true,
	-- 		})
	-- 		require("monokai-nightasty").load()
	-- 		vim.cmd.colorscheme("monokai-nightasty")
	-- 	end,
	-- },
}
