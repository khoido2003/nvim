return {
	{
		"echasnovski/mini.statusline",
		event = "BufReadPost",
		version = "*",
		lazy = true,
		config = function()
			local MiniStatusline = require("mini.statusline")

			-- Custom active statusline function
			local function custom_active()
				-- Default sections
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
				local git = MiniStatusline.section_git({ trunc_width = 75 })
				local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
				local diff = MiniStatusline.section_diff({ trunc_width = 75 })
				local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
				local searchcount = MiniStatusline.section_searchcount({ trunc_width = 75 })

				-- Custom location: show only line info (no column)
				local line_num = vim.api.nvim_win_get_cursor(0)[1] -- Current line number
				local total_lines = vim.api.nvim_buf_line_count(0) -- Total lines
				local location = string.format("%d|%d", line_num, total_lines)

				-- Custom file info: show only filename
				local filename = vim.fn.expand("%:t")
				local fileinfo = filename == "" and "[No Name]" or filename

				-- Combine sections into groups
				return MiniStatusline.combine_groups({
					{ hl = mode_hl, strings = { mode } }, -- Mode
					{ hl = "MiniStatuslineDevinfo", strings = { git } }, -- Git branch
					{ hl = "MiniStatuslineDevinfo", strings = { diff } }, -- Diff
					{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } }, -- Diagnostics
					"%<", -- Truncate point
					{ hl = "MiniStatuslineFilename", strings = { fileinfo } }, -- Filename

					"%=", -- Right-align

					{ hl = "MiniStatuslineDevinfo", strings = { lsp } }, -- LSP info
					{ hl = mode_hl, strings = { searchcount, location } },
				})
			end

			MiniStatusline.setup({
				content = {
					active = custom_active,
					inactive = nil,
				},
				set_vim_settings = true,
			})
		end,
	},
}
