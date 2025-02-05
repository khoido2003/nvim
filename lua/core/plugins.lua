-- plugins.lua
require("lazy").setup({
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"numToStr/Comment.nvim",
		lazy = true,
		config = function()
			require("Comment").setup()
		end,
	},

	{ "lewis6991/gitsigns.nvim", lazy = true },

	{ "onsails/lspkind.nvim", lazy = true },

	-- Icon
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	-- Multiple cursor
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},

	-- C# LSP server
	{
		"seblj/roslyn.nvim",
		lazy = true,
		ft = "cs",
		opts = {
			exe = {
				"dotnet",
				"C:/Users/Lenovo/.vscode/extensions/ms-dotnettools.csharp-2.61.28-win32-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
			},
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=C:/Users/Lenovo/.roslyn_logs",
			},
			filewatching = true,
			lock_target = true,
		},
	},

	{ "nvim-tree/nvim-tree.lua", lazy = true },

	-- Auto close {}
	{ "windwp/nvim-autopairs", lazy = true },

	-- Syntax Highlighting and Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },

		dependencies = {
			"windwp/nvim-ts-autotag",
		},
	},
	-- Terminal management
	{
		"akinsho/toggleterm.nvim",
		version = "*", -- Optional: use the latest version,
		lazy = true,
		autostart = true,
		keys = { "<c-\\>", "<C-t>" },
	},

	-- LSP and Autocompletion
	{ "williamboman/mason.nvim", lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
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

	{ "L3MON4D3/LuaSnip", lazy = true },

	{ "tpope/vim-fugitive", lazy = true },

	-- Telescope for Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
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

	-- colorizer to show color in css/html, ...
	{ "norcalli/nvim-colorizer.lua", lazy = true },

	{
		"stevearc/conform.nvim",
		opts = {},
		lazy = true,
	},

	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
})

-----------------------------------------------------------------

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
		"rust",
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

-- ////////////////////////////////////////////////

-- Monokai colorscheme
local opts = {
	dark_style_background = "default", -- default, dark, transparent, #RRGGBB
	light_style_background = "default", -- default, dark, transparent, #RRGGBB
	hl_styles = {
		comments = { italic = false },
		keywords = { italic = false },
		functions = { italic = false },
		variables = { italic = false },

		floats = "default", -- default, dark, transparent
		sidebars = "default", -- default, dark, transparent
	},

	on_highlights = function(highlights, _)
		-- Disable bold and italic for various elements
		for _, group in pairs(highlights) do
			if group.italic then
				group.italic = false
			end
			if group.bold then
				group.bold = false
			end
		end
	end,
	color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
	dim_inactive = false,
	lualine_bold = true,
	lualine_style = "default", -- "dark", "light" or "default" (default follows dark/light style)

	markdown_header_marks = true,
	terminal_colors = true,
	cache = true,
	auto_enable_plugins = true,
}

require("monokai-nightasty").setup(opts)
require("monokai-nightasty").load()
vim.cmd([[colorscheme monokai-nightasty]])

-- ////////////////////////////////////////////////

-- Lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = " ",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 102,
			tabline = 102,
			winbar = 102,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "filetype" },
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

-------------------------------------------------------------------------

-- CONFIGURATIONS

-- telescope.nvim setup
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git/*", "*.log" },
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
	diagnostics = { enable = false },
})

-- /////////////////////////////////////////////////////

-- GIT Support
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "+" },
		change = { text = "~" },
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

-- ////////////////////////////////////////////////

-- Toggle terminal
require("toggleterm").setup({
	size = 20, -- Height of the terminal window
	open_mapping = [[<c-\>]], -- Shortcut to toggle the terminal
	direction = "tab", -- Options: 'horizontal', 'vertical', 'tab', 'float'
	shade_terminals = true, -- Shades background of terminal

	start_in_insert = true, -- Start in insert mode for terminals
	insert_mappings = true, -- Apply open mapping in insert mode
	terminal_mappings = true, -- Apply open mapping in terminal mode
})

-- ////////////////////////////////////////////////

-- nvim-autopairs setup
require("nvim-autopairs").setup({
	check_ts = true, -- Enable treesitter support
})

-- Configure nvim-web-devicons (you can customize as needed)
require("nvim-web-devicons").setup({
	default = true, -- Use default icons for unrecognized filetypes
})

-- //////////////////////////////////////////////////////////

-- colorizer
require("colorizer").setup()

-- Auto close tag

require("nvim-ts-autotag").setup({
	filetypes = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"svelte",
		"php",
		"markdown",
	},

	did_setup = nil, -- Function called after setup (optional)
	setup = nil, -- Function to customize setup behavior (optional)
	get_opts = nil, -- Function to get options dynamically
})
