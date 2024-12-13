-- plugins.lua
require("lazy").setup({

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
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
	"mg979/vim-visual-multi", -- Using ctrl + n to select multiple element.

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
			lock_target = true,
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
		autostart = true,
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

require("catppuccin").setup({
	flavour = "auto", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = true, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = {}, -- Change the style of comments
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {
		mocha = {
			base = "#18191a",
			mantle = "#18191a",
			crust = "#18191a",
		},
	},
	custom_highlights = {},
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

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
	filters = {
		custom = { ".git", "node_modules", "__pycache__" }, -- Ignore heavy directories
	},
	diagnostics = { enable = false }, -- Disable diagnostics
})

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

-- colorizer
require("colorizer").setup()
