-- ENVIRONMENT REQUIREMENTS:
--
-- REQUIRED:
--   - Neovim >= 0.11.7
--   - ripgrep (rg)  - for live_grep / vimgrep
--       Windows: winget install BurntSushi.ripgrep.MSVC
--                or scoop install ripgrep
--   - fd             - for find_files
--       Windows: winget install sharkdp.fd
--                or scoop install fd
--
-- FOR telescope-fzf-native.nvim (compiled C sorter, major speed boost):
--   - CMake >= 3.17   : winget install Kitware.CMake
--   - MinGW/GCC       : Install MSYS2 from https://www.msys2.org
--                       then in MSYS2 MINGW64 terminal:
--                         pacman -S mingw-w64-x86_64-gcc make
--                       then add to Windows PATH:
--                         C:\msys64\mingw64\bin
--
-- OPTIONAL BUT RECOMMENDED:
--   - bat             - syntax-highlighted previews
--       Windows: winget install sharkdp.bat
--   - delta           - better diff previews
--       Windows: winget install dandavison.delta

return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			lazy = true,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			-- Requires CMake + MinGW GCC on Windows (see header comments)
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -G 'MinGW Makefiles' && cmake --build build --config Release",
			-- If CMake issues persist, delete the 'build' folder inside the
			-- plugin directory and re-run :Lazy clean + :Lazy build
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local extensions = telescope.extensions
		local themes = require("telescope.themes")

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			defaults = {

				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!**/.git/*",
					"--glob=!**/node_modules/*",
					"--glob=!**/target/*",
					"--glob=!**/dist/*",
					"--glob=!**/build/*",
				},

				generic_sorter = require("telescope.sorters").get_fzf_sorter,
				file_sorter = require("telescope.sorters").get_fzf_sorter,

				path_display = { "truncate" },

				cache_picker = {
					num_pickers = 5,
					limit_entries = 1000,
				},

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
					"--exclude",
					"node_modules",
					"--exclude",
					"dist",
					"--exclude",
					"build",
					"--exclude",
					"target",
				},

				file_ignore_patterns = {
					-- Unity / C# build artifacts
					"%.meta$",
					"%.csproj$",
					"%.sln$",
					"%.pdb$",
					"%.mdb$",
					"^Library/",
					"^Temp/",
					"^Obj/",
					"^Build/",
					"^UserSettings/",
					-- Compiled outputs
					"%.pyc$",
					"%.class$",
					"%.o$",
					"%.obj$",
					"%.exe$",
					"%.dll$",
					"%.so$",
					"%.dylib$",
					-- Lock files and source maps
					"package%-lock%.json",
					"yarn%.lock",
					"pnpm%-lock%.yaml",
					"%.min%.js$",
					"%.min%.css$",
					"%.map$",
					-- Binary / media (fd doesn't filter these by default)
					"%.jpg$",
					"%.jpeg$",
					"%.png$",
					"%.gif$",
					"%.mp4$",
					"%.mkv$",
					"%.mp3$",
					"%.wav$",
					"%.zip$",
					"%.tar$",
					"%.gz$",
					"%.7z$",
					"%.pdf$",
					"%.db$",
					"%.sqlite$",
					"%.sqlite3$",
				},
			},

			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
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
						i = { ["<C-d>"] = "delete_buffer" },
						n = { ["<C-d>"] = "delete_buffer" },
					},
				},
				oldfiles = {
					theme = "dropdown",
					previewer = false,
				},
				keymaps = {
					theme = "dropdown",
					layout_config = { width = 0.8, height = 0.4 },
				},
				help_tags = {
					theme = "dropdown",
					previewer = false,
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		-- Keymaps
		local map = vim.keymap.set
		map("n", "<leader>f", function()
			extensions.live_grep_args.live_grep_args(themes.get_dropdown({ previewer = true }))
		end, { desc = "Live Grep Args" })

		map("n", "f", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({ previewer = true }))
		end, { desc = "Fuzzy Find in Buffer" })

		map("n", "<leader>fo", function()
			builtin.oldfiles(themes.get_dropdown({ previewer = false }))
		end, { desc = "Recent Files" })

		map("n", "<leader>fk", function()
			builtin.keymaps(themes.get_dropdown({ previewer = false }))
		end, { desc = "Keymaps" })

		map("n", "<Tab>", function()
			builtin.buffers(themes.get_dropdown({ previewer = false }))
		end, { desc = "Buffers" })

		map("n", "<leader>ff", function()
			builtin.find_files(themes.get_dropdown({ previewer = false, hidden = true }))
		end, { desc = "Find Files" })

		map("n", "<leader>gr", function()
			builtin.lsp_references(themes.get_dropdown({ previewer = false }))
		end, { desc = "LSP References" })
	end,
}
