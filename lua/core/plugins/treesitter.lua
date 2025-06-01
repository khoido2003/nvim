return {
	-- Syntax Highlighting and Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- "java",
					-- "c_sharp",
					-- "python",
					-- "javascript",
					-- "typescript",
					-- "cpp",
					-- "c",
					-- "zig",
					-- "rust",
					-- "dockerfile",
					-- "proto",
					-- "yaml",
					-- "go",
					-- "sql",
					-- "css",
					-- "html",
					-- "scss",
					-- "prisma",
					-- "svelte",
					-- "lua",
					-- "json",
					-- "tsx",
					-- "toml",
					-- "gdscript",
				},
				auto_install = true, -- Automatically install missing parsers,
				-- Sync installation (installs parsers synchronously)
				sync_install = true,

				-- Add modules explicitly
				modules = {},
				-- Ignore installing specific parsers
				ignore_install = {},
				highlight = {
					enable = true, -- Enable syntax highlighting
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = false, -- Enable Tree-sitter indentation
				},
			})

			vim.api.nvim_create_autocmd("BufReadPre", {
				callback = function()
					if vim.fn.line("$") > 15000 then
						vim.cmd("TSBufDisable highlight")
					end
				end,
			})
			-- USING ZIG AS COMPILER FOR TREESITTER
			require("nvim-treesitter.install").compilers = { "gcc", "zig" }
		end,
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				event = { "BufReadPost", "BufNewFile" },
				config = function()
					require("nvim-ts-autotag").setup({
						filetypes = {
							"html",
							"javascript",
							"typescript",
							"jsx",
							"tsx",
							"vue",
							"svelte",
							"php",
							"markdown",
						},

						did_setup = nil,
						setup = nil,
						get_opts = nil,
					})
				end,
			},
		},
	},
}
