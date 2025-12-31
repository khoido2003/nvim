return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	branch = "main",
	config = function()
		local ts = require("nvim-treesitter")

		ts.setup()

		ts.install({
			-- scripting / config
			"lua",
			"json",
			"jsonc",
			"yaml",
			"toml",

			-- web
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",

			-- backend / systems
			"c",
			"cpp",
			"c_sharp",
			"go",
			"rust",

			-- data / misc
			"bash",
			"regex",
			"markdown",
			"markdown_inline",
		})

		local ignore_filetypes = {
			"checkhealth",
			"lazy",
			"mason",
			"snacks_dashboard",
			"snacks_notif",
			"snacks_win",
		}

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				if vim.tbl_contains(ignore_filetypes, ev.match) then
					return
				end

				pcall(vim.treesitter.start, ev.buf)

				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
