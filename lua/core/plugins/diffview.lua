return {
	"sindrets/diffview.nvim",
	lazy = true,
	dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	config = function()
		require("diffview").setup({
			view = {
				merge_tool = {
					-- Configure the layout for the merge tool
					layout = "diff3_mixed", -- Use a 3-way merge layout
					win_config = function()
						return {
							{ -- Left window (e.g., "base" or "local")
								type = "split",
								win = -1, -- Main window
								region = { row = 0, col = 0, width = vim.o.columns / 2, height = vim.o.lines - 5 },
							},
							{ -- Right window (e.g., "theirs" or "remote")
								type = "split",
								win = -1,
								region = {
									row = 0,
									col = vim.o.columns / 2,
									width = vim.o.columns / 2,
									height = vim.o.lines - 5,
								},
							},
							{ -- Bottom window (merge result)
								type = "split",
								win = -1,
								region = { row = vim.o.lines - 5, col = 0, width = vim.o.columns, height = 5 },
							},
						}
					end,
				},
			},
		})

		local Hydra = require("hydra")
		local actions = require("diffview.actions")

		Hydra({
			name = "Diffview",
			hint = [[
 Diffview Keybindings
 -------------------
 Navigation:
 _<Tab>_: Next file      _<S-Tab>_: Prev file
 _[F_: First file        _]F_: Last file
 _[x_: Prev conflict     _]x_: Next conflict

 Conflict Resolution:
 _co_: Choose ours       _ct_: Choose theirs
 _cb_: Choose base       _ca_: Choose all
 _dx_: Delete conflict
 _cO_: Ours (file)       _cT_: Theirs (file)
 _cB_: Base (file)       _cA_: All (file)
 _dX_: Delete (file)

 File Panel:
 _e_: Focus files        _b_: Toggle files
 _s_: Stage entry        _S_: Stage all
 _U_: Unstage all        _X_: Restore entry
 _R_: Refresh files      _i_: Toggle list/tree

 View:
 _<C-x>_: Cycle layout   _gf_: Open file
 _g?_: Help panel

 _q_: Quit Hydra
 ]],
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = {
					type = "window",
					position = "bottom-right",
					show_name = true,
				},
				on_enter = function()
					vim.cmd('echo "Entering Diffview Hydra"')
				end,
				on_exit = function()
					vim.cmd('echo "Exiting Diffview Hydra"')
				end,
			},
			mode = "n",
			body = "<leader>dv",
			heads = {
				-- Navigation
				{ "<Tab>", actions.select_next_entry, { desc = "Next file" } },
				{ "<S-Tab>", actions.select_prev_entry, { desc = "Prev file" } },
				{ "[F", actions.select_first_entry, { desc = "First file" } },
				{ "]F", actions.select_last_entry, { desc = "Last file" } },
				{ "[x", actions.prev_conflict, { desc = "Prev conflict" } },
				{ "]x", actions.next_conflict, { desc = "Next conflict" } },

				-- Conflict Resolution
				{ "co", actions.conflict_choose("ours"), { desc = "Choose ours" } },
				{ "ct", actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
				{ "cb", actions.conflict_choose("base"), { desc = "Choose base" } },
				{ "ca", actions.conflict_choose("all"), { desc = "Choose all" } },
				{ "dx", actions.conflict_choose("none"), { desc = "Delete conflict" } },
				{ "cO", actions.conflict_choose_all("ours"), { desc = "Ours (file)" } },
				{ "cT", actions.conflict_choose_all("theirs"), { desc = "Theirs (file)" } },
				{ "cB", actions.conflict_choose_all("base"), { desc = "Base (file)" } },
				{ "cA", actions.conflict_choose_all("all"), { desc = "All (file)" } },
				{ "dX", actions.conflict_choose_all("none"), { desc = "Delete (file)" } },

				-- File Panel
				{ "e", actions.focus_files, { desc = "Focus files" } },
				{ "b", actions.toggle_files, { desc = "Toggle files" } },
				{ "s", actions.toggle_stage_entry, { desc = "Stage entry" } },
				{ "S", actions.stage_all, { desc = "Stage all" } },
				{ "U", actions.unstage_all, { desc = "Unstage all" } },
				{ "X", actions.restore_entry, { desc = "Restore entry" } },
				{ "R", actions.refresh_files, { desc = "Refresh files" } },
				{ "i", actions.listing_style, { desc = "Toggle list/tree" } },

				-- View
				{ "<C-x>", actions.cycle_layout, { desc = "Cycle layout" } },
				{ "gf", actions.goto_file_edit, { desc = "Open file" } },
				{ "g?", actions.help("view"), { desc = "Help panel" } },

				-- Exit
				{ "q", nil, { exit = true, nowait = true, desc = "Quit Hydra" } },
				{ "<Esc>", nil, { exit = true, desc = false } },
			},
		})
	end,
}
