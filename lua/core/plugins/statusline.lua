return {
	"echasnovski/mini.statusline",
	event = "VeryLazy",
	version = "*",
	lazy = true,
	config = function()
		require("mini.statusline").setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					-- Custom section to show only the file name
					local filename = vim.fn.fnamemodify(vim.fn.bufname(), ":t")
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.is_truncated(40) and ""
						or (vim.fn.line(".") .. "|" .. vim.fn.line("$"))
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename } }, -- Use custom filename
						"%=", -- End left alignment
						{ hl = "MiniStatuslineFilename", strings = { fileinfo } },
						{ hl = "MiniStatuslineFileinfo", strings = { lsp } },
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
				inactive = nil,
			},
			use_icons = true,
		})
	end,
}
