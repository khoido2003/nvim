return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.1",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			lazy = true,
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local extensions = telescope.extensions
		local themes = require("telescope.themes")

		telescope.setup({
			defaults = {
				grep_backend = "rg",

				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--no-ignore",
					"--glob=!**/.git/*",
					"--glob=!**/node_modules/*",
					"--glob=!**/target/*",
					"--glob=!**/dist/*",
					"--glob=!**/build/*",
				},
				path_display = { "smart" },
				mappings = {
					i = {
						["<Esc>"] = require("telescope.actions").close,
					},
				},
				find_command = {
					"fd",
					"--type",
					"f",
					"--hidden",
					"--strip-cwd-prefix",
					"--ignore",
					"--max-depth",
					"10",
					"--exclude",
					".git",
					"--exclude",
					"Library",
					"--exclude",
					"obj",
					"--exclude",
					"Temp",
				},
				file_ignore_patterns = {
					"node_modules",
					"dist",
					"build",
					"target",
					"out",
					"bin",
					"obj",
					"coverage",
					"vendor",
					".venv",
					"venv",
					"__pycache__",
					"%.egg%-info",
					"bower_components",
					"%.pnpm%-store",
					"%.tmp",
					"%.temp",
					"%.cache",
					"%.DS_Store",
					"%.swp",
					"%.swo",
					"%.bak",
					"%.backup",
					"%.pyc",
					"%.pyo",
					"%.class",
					"%.o",
					"%.obj",

					"^Library/",
					"^Logs/",
					"^Temp/",
					"^Obj/",
					"^Build/",
					"^UserSettings/",
					"^.gradle/",
					"%.csproj$",
					"%.unityproj$",
					"%.sln$",
					"%.pidb$",
					"%.booproj$",
					"%.svd$",
					"%.pdb$",
					"%.mdb$",
					"%.opendb$",
					"%.VC%.db$",
					"%.meta$",

					"%.jpg$",
					"%.jpeg$",
					"%.png$",
					"%.gif$",
					"%.svg$",
					"%.mp4$",
					"%.mkv$",
					"%.avi$",
					"%.mp3$",
					"%.wav$",
					"%.zip$",
					"%.tar$",
					"%.gz$",
					"%.7z$",
					"%.exe$",
					"%.dll$",
					"%.so$",
					"%.dylib$",
					"%.pdf$",

					"package%-lock%.json",
					"yarn%.lock",
					"pnpm%-lock%.yaml",
					"%.min%.js$",
					"%.min%.css$",
					"%.map$",
					"%.db$",
					"%.sqlite$",
					"%.sqlite3$",

					"^.github/",
					"^.gitlab/",
					"%.gitignore$",
					"%.gitattributes$",
					"^.circleci/",
					"%.travis%.yml$",
				},
			},

			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
					path_display = { "smart" },
				},
				live_grep = {
					theme = "dropdown",
					previewer = true,
				},
				current_buffer_fuzzy_find = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					sort_lastused = true,
					theme = "dropdown",
					previewer = false,
					path_display = { "tail" },
					mappings = {
						i = {
							["<C-d>"] = "delete_buffer",
						},
						n = {
							["<C-d>"] = "delete_buffer",
						},
					},
				},
				oldfiles = {
					theme = "dropdown",
					previewer = false,
					path_display = { "smart" },
				},
				keymaps = {
					theme = "dropdown",
					layout_config = {
						width = 0.8,
						height = 0.4,
					},
				},
				help_tags = {
					theme = "dropdown",
					previewer = false,
				},
			},
		})

		-- Load extensions
		telescope.load_extension("live_grep_args")

		-- Minimal dropdown keymaps
		local map = vim.keymap.set
		map("n", "<leader>f", function()
			extensions.live_grep_args.live_grep_args(themes.get_dropdown({ previewer = true }))
		end, { desc = "Live Grep Args (dropdown)" })

		map("n", "f", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({ previewer = true }))
		end, { desc = "Fuzzy Find in Buffer (dropdown)" })

		map("n", "<leader>fo", function()
			builtin.oldfiles(themes.get_dropdown({ previewer = false }))
		end, { desc = "Recent Files (dropdown)" })

		map("n", "<leader>fk", function()
			builtin.keymaps(themes.get_dropdown({ previewer = false }))
		end, { desc = "Keymaps (dropdown)" })

		map("n", "<Tab>", function()
			builtin.buffers(themes.get_dropdown({ previewer = false }))
		end, { desc = "Buffers (dropdown)" })

		map("n", "<leader>ff", function()
			builtin.find_files(themes.get_dropdown({ previewer = false, hidden = true }))
		end, { desc = "Find Files (dropdown)" })

		map("n", "<leader>gr", function()
			builtin.lsp_references(themes.get_dropdown({ previewer = false }))
		end, { desc = "LSP References (dropdown)" })
	end,
}
