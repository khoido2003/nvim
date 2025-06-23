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
	end,
}
