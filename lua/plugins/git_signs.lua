return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			debug_mode = true, -- Enable debug logging
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				-- Notify when Gitsigns attaches
				vim.notify("Gitsigns attached to buffer " .. bufnr, vim.log.levels.INFO)

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>nh", gitsigns.next_hunk, { desc = "Next hunk" })
				map("n", "<Leader>pv", gitsigns.prev_hunk, { desc = "Previous hunk" })

				-- Actions
				map("n", "<Leader>rh", gitsigns.reset_hunk, { desc = "Reset hunk" })
				map("v", "<Leader>rh", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk (visual)" })
				map("n", "<Leader>rb", gitsigns.reset_buffer, { desc = "Reset buffer" })
				map("n", "<Leader>ph", gitsigns.preview_hunk, { desc = "Preview hunk" })
				map("n", "<Leader>df", gitsigns.diffthis, { desc = "Diff this" })
				map("n", "<Leader>bl", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame line" })

				-- Toggles
				map("n", "<Leader>gs", gitsigns.toggle_signs, { desc = "Toggle signs" })
				map("n", "<Leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
				map("n", "<Leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

				-- Additional actions
				map("n", "<Leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
				map("n", "<Leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff this (~)" })
				map("n", "<Leader>hQ", function()
					gitsigns.setqflist("all")
				end, { desc = "Set quickfix list (all)" })
				map("n", "<Leader>hq", gitsigns.setqflist, { desc = "Set quickfix list" })
			end,
		})
	end,
}
