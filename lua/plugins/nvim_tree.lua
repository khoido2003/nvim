return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
			sync_root_with_cwd = false,
			update_cwd = false,
			hijack_netrw = false,
			reload_on_bufenter = false,
			git = {
				enable = true,
				timeout = 5000,
			},
			diagnostics = { enable = false },

			filters = {
				custom = {
					-- Common junk / OS
					".DS_Store",
					"thumbs.db",
					"desktop.ini",

					-- Package managers
					"node_modules",
					"package%-lock.json$",
					"yarn.lock",
					"pnpm%-lock.yaml",

					-- Python
					"__pycache__",
					".venv",
					"venv",
					".mypy_cache",
					".pytest_cache",
					".tox",
					".ruff_cache",
					".egg%-info$",

					-- Unity
					"Library",
					"Logs",
					"Temp",
					"Build",
					"UserSettings",
					"obj",
					"bin",
					".gradle",
					".meta$",
					".unityproj$",
					".csproj$",
					".sln$",
					".pidb$",
					".booproj$",
					".svd$",
					".pdb$",
					".mdb$",
					".opendb$",
					".VC.db$",

					-- Java / JVM
					"target",
					".gradle",
					".idea",
					"*.iml",

					-- C / C++
					"%.o$",
					"%.obj$",
					"%.so$",
					"%.dll$",
					"%.dylib$",
					"%.exe$",

					-- Logs / databases
					"%.log$",
					"%.sqlite$",
					"%.sqlite3$",
					"%.db$",

					-- Build outputs
					"dist",
					"out",
					"coverage",

					-- Backups / swap
					"%.swp$",
					"%.swo$",
					"%.bak$",
					"%.backup$",
					"%.tmp$",
					"%.temp$",

					-- Minified / maps
					"%.min.js$",
					"%.min.css$",
					"%.map$",

					-- Media / binaries
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
					"%.pdf$",
				},
				dotfiles = false,
				exclude = { ".gitignore", ".env", "routes" },
			},
		})
	end,
}
