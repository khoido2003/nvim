return {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
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
					"node_modules",
					"__pycache__",
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
					"*.egg-info",
					"*.tmp",
					"*.temp",
					"*.cache",
					".DS_Store",
					"*.swp",
					"*.swo",
					"*.bak",
					"*.backup",
					"*.pyc",
					"*.pyo",
					"*.class",
					"*.o",
					"*.obj",
					"*.jpg",
					"*.jpeg",
					"*.png",
					"*.gif",
					"*.svg",
					"*.mp4",
					"*.mkv",
					"*.avi",
					"*.mp3",
					"*.wav",
					"*.zip",
					"*.tar",
					"*.gz",
					"*.7z",
					"*.exe",
					"*.dll",
					"*.so",
					"*.dylib",
					"*.pdf",
					"package-lock.json",
					"yarn.lock",
					"pnpm-lock.yaml",
					"*.min.js",
					"*.min.css",
					"*.map",
					"*.db",
					"*.sqlite",
					"*.sqlite3",
					"Library/*", -- Unity local cache
					"Logs/*", -- Unity log files
					"Temp/*", -- Temp build stuff
					"Obj/*", -- Build object cache
					"Build/*", -- Compiled builds
					"UserSettings/*", -- Local Unity editor settings
					".gradle/*", -- Android builds
					"*.csproj", -- Auto-generated C# project files
					"*.unityproj", -- Old Unity project format
					"*.sln", -- Visual Studio solution
					"*.tmp", -- Temp files
					"*.pidb", -- Unity metadata
					"*.booproj", -- Rider metadata
					"*.svd", -- Debugger files
					"*.pdb", -- Debug symbols
					"*.mdb", -- Debug database
					"*.opendb", -- Local cache
					"*.VC.db", -- VS cache
					"*.meta",
				},
				dotfiles = true,
				exclude = { ".gitignore", "routes" },
			},
		})
	end,
}
