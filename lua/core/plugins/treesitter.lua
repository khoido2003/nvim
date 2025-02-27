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
				auto_install = false, -- Automatically install missing parsers,
				-- Sync installation (installs parsers synchronously)
				sync_install = false,

				-- Add modules explicitly
				modules = {},
				-- Ignore installing specific parsers
				ignore_install = {},
				highlight = { enable = true, additional_vim_regex_highlighting = false, debounce = 100 },
				indent = {
					enable = false, -- Enable Tree-sitter indentation
				},
			})

			require("nvim-treesitter.install").compilers = { "zig" }
		end,
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
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
