-- plugins.lua
require("lazy").setup({
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		event = "VeryLazy",
	},
	-- {
	--     "catppuccin/nvim",
	--     name = "catppuccin",
	--     priority = 1000,
	--     lazy = true,
	--     event = "VeryLazy"
	-- },
	-- {
	--     "goolord/alpha-nvim",
	--     config = function()
	--         require "alpha".setup(require "alpha.themes.dashboard".config)
	--     end
	-- },

	{
		"mhinz/vim-startify",
		lazy = false,
	},

	"lewis6991/gitsigns.nvim",
	"onsails/lspkind.nvim",
	-- -- Kanagawa theme
	-- "rebelot/kanagawa.nvim",

	-- Icon
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	-- Multiple cursor
	"mg979/vim-visual-multi",
	-- C# LSP server
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {
			exe = {
				"dotnet",
				"C:/Users/Lenovo/.vscode/extensions/ms-dotnettools.csharp-2.55.29-win32-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
			},
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=C:/Users/Lenovo/.roslyn_logs",
			},
			on_new_config = function(new_config, new_root_dir)
				-- Use the dynamically created pipe name
				new_config.cmd = { "dotnet", "\\\\.\\pipe\\f7d4a339" }
			end,
			filewatching = true,
			config = {
				settings = {
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_parameters = true,
					},
					["csharp|completion"] = {
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
				},
			},
		},
	},
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	-- Auto close {}
	"windwp/nvim-autopairs",
	-- Tabnine AI
	{ "codota/tabnine-nvim", build = "pwsh.exe -file .\\dl_binaries.ps1" },
	-- Syntax Highlighting and Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
	},
	-- Terminal management
	{
		"akinsho/toggleterm.nvim",
		version = "*", -- Optional: use the latest version,
		lazy = true,
		keys = { "<c-\\>", "<C-t>" },
		config = function()
			require("toggleterm").setup({
				size = 20, -- Height of the terminal window
				open_mapping = [[<c-\>]], -- Shortcut to toggle the terminal
				direction = "tab", -- Options: 'horizontal', 'vertical', 'tab', 'float'
				shade_terminals = true, -- Shades background of terminal
				float_opts = {
					border = "curved", -- Border style: 'single', 'double', 'shadow', etc.
				},
			})

			-- Custom keybinding to create new terminal
			vim.api.nvim_set_keymap("n", "<C-t>", ":ToggleTerm<CR>", { noremap = true, silent = true })
		end,
	},
	-- LSP and Autocompletion
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-path",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-buffer",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
		event = "InsertEnter",
	},
	"L3MON4D3/LuaSnip",

	"nvim-pack/nvim-spectre",
	-- Version Control
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	-- Telescope for Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim", -- Add this line to install the live_grep_args extension
		},
		cmd = { "Telescope" },
		config = function()
			local telescope = require("telescope")

			-- first setup telescope
			telescope.setup({
				-- your config
			})

			-- then load the extension
			telescope.load_extension("live_grep_args")
		end,
	},
	-- Language Specific Tools
	{
		"OmniSharp/omnisharp-vim",
		lazy = true,
		ft = "cs",
	},
	{
		"fatih/vim-go", -- Go development
		run = ":GoUpdateBinaries",
		lazy = true,
		ft = "go",
	},
	-- Multiple cursor
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
	-- colorizer to show color in css/html, ...
	"norcalli/nvim-colorizer.lua",

	{
		"stevearc/conform.nvim",
		opts = {},
	},
})

-- ///////////////////////////////////////////////////
-- /////////////////////////////////////////////////////

-- CONFIGURATIONS

-- telescope.nvim setup
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git/*", "*.log" }, -- Ignore specific files or directories
	},
	extensions = {
		lsp_handlers = {
			code_action = {
				telescope = require("telescope.themes").get_dropdown({}),
			},
		},
	},
})

-- /////////////////////////////////////////////////////////////

-- nvim-tree setup
require("nvim-tree").setup({
	sync_root_with_cwd = true, -- Sync the tree with the current working directory
	update_cwd = true, -- Update the tree when you change directories
	hijack_netrw = true,
	reload_on_bufenter = true,
})

require("nvim-treesitter.parsers").get_parser_configs().c_sharp = {
	install_info = {
		url = "https://github.com/tree-sitter/tree-sitter-c-sharp", -- Specify the parser's repo
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
	},
	filetype = "cs",
}

-- //////////////////////////////////////////////////////

-- GIT Support
require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "┃" },
		change = { text = "┃" },
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
})

-- ////////////////////////////////////////////////////

-- LUA line

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = {
				a = { fg = "#ffffff", bg = "#2e3238", gui = "bold" }, -- Normal mode
				b = { fg = "#c5c8c6", bg = "#202426" }, -- Background for branch, diagnostics (dark grayish)
				c = { fg = "#c5c8c6", bg = "#202426" }, -- Background for filename (dark grayish)
			},
			insert = {
				a = { fg = "#ffffff", bg = "#9d7cd8", gui = "bold" }, -- Insert mode (background dark blue-gray)
			},
			visual = {
				a = { fg = "#ffffff", bg = "#e46876", gui = "bold" }, -- Visual mode (background muted gray)
			},
			replace = {
				a = { fg = "#ffffff", bg = "#5a6374", gui = "bold" }, -- Replace mode (background rose red)
			},
			command = {
				a = { fg = "#ffffff", bg = "#364F6B", gui = "bold" }, -- Command mode (background purple)
			},
			inactive = {
				a = { fg = "#c5c8c6", bg = "#1c1f24" }, -- Inactive sections have a muted gray background
				b = { fg = "#c5c8c6", bg = "#1c1f24" },
				c = { fg = "#c5c8c6", bg = "#1c1f24" },
			},
		},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- //////////////////////////////////////

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"java",
		"c_sharp",
		"python",
		"javascript",
		"typescript",
		"cpp",
		"c",
		"zig",
		"rust",
		"dockerfile",
		"proto",
		"http",
		"yaml",
		"go",
		"sql",
		"css",
		"html",
		"scss",
		"prisma",
		"svelte",
		"lua",
		"json",
		"tsx",
		"gitignore",
		"toml",
		"php",
	},
	auto_install = true, -- Automatically install missing parsers,
	-- Sync installation (installs parsers synchronously)
	sync_install = false,

	-- Add modules explicitly
	modules = {},
	-- Ignore installing specific parsers
	ignore_install = {},
	highlight = {
		enable = true, -- Enable syntax highlighting
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true, -- Enable Tree-sitter indentation
	},
})

-- USING ZIG AS COMPILER FOR TREESITTER
require("nvim-treesitter.install").compilers = { "zig" }

-- /////////////////////////////////////////

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ////////////////////////////////////////////////

-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<Tab>",
--   dismiss_keymap = "<C-]>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt", "NvimTree"},
--   log_file_path = nil, -- absolute path to Tabnine log file
--   ignore_certificate_errors = false,
-- })

-- nvim-autopairs setup
require("nvim-autopairs").setup({
	check_ts = true, -- Enable treesitter support
})

-- Configure nvim-web-devicons (you can customize as needed)
require("nvim-web-devicons").setup({
	default = true, -- Use default icons for unrecognized filetypes
})

-- //////////////////////////////////////////////////////////////////////////////////////

require("rose-pine").setup({
	variant = "moon", -- auto, main, moon, or dawn
	dark_variant = "moon", -- main, moon, or dawn
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	enable = {
		terminal = true,
		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
		migrations = true, -- Handle deprecated options automatically
	},
	styles = {
		bold = true,
		italic = false,
		transparency = false,
	},
	groups = {
		border = "muted",
		link = "iris",
		panel = "surface",
		error = "love",
		hint = "iris",
		info = "foam",
		note = "pine",
		todo = "rose",
		warn = "gold",
		git_add = "foam",
		git_change = "rose",
		git_delete = "love",
		git_dirty = "rose",
		git_ignore = "muted",
		git_merge = "iris",
		git_rename = "pine",
		git_stage = "iris",
		git_text = "rose",
		git_untracked = "subtle",
		h1 = "iris",
		h2 = "foam",
		h3 = "rose",
		h4 = "gold",
		h5 = "pine",
		h6 = "foam",
	},
	palette = {
		-- Override the builtin palette per variant
		moon = {
			-- base = '#1c1f24',   -- Neutral dark background
			-- overlay = '#2e3238', -- Softer dark overlay

			base = "#18191a",
			overlay = "#363738",
		},
	},
	highlight_groups = {
		-- Customize floating and popup backgrounds
		Normal = { bg = "#18191a" },
		NormalFloat = { bg = "#18191a" },
		FloatBorder = { bg = "#18191a", fg = "#363738" },
		Pmenu = { bg = "#363738", fg = "#c5c8c6" },
		PmenuSel = { bg = "#363738", fg = "#ffffff" },
		-- Telescope specific overrides
		TelescopeBorder = { fg = "#363738", bg = "#18191a" }, -- Border of Telescope popups
		TelescopePromptBorder = { fg = "#363738", bg = "#18191a" }, -- Prompt border
		TelescopeResultsBorder = { fg = "#363738", bg = "#18191a" }, -- Results border
		TelescopePreviewBorder = { fg = "#363738", bg = "#18191a" }, -- Preview border
	},
	before_highlight = function(group, highlight, palette)
		-- Adjust palette colors for specific groups
		if group == "NormalFloat" or group == "TelescopeNormal" then
			highlight.bg = palette.base
		end
	end,
})

-- colorizer
require("colorizer").setup()
