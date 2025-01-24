-- plugins.lua
require("lazy").setup({

	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = true, priority = 1000 },
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
	{ "mg979/vim-visual-multi", lazy = true }, -- Using ctrl + n to select multiple element.

	-- C# LSP server
	{
		"seblj/roslyn.nvim",
		lazy = true,
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
						dotnet_enable_references_code_lens = false,
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

	{ "nvim-tree/nvim-tree.lua", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

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
		config = function()
			require("toggleterm").setup({
				size = 20, -- Height of the terminal window
				open_mapping = [[<c-\>]], -- Shortcut to toggle the terminal
				direction = "tab", -- Options: 'horizontal', 'vertical', 'tab', 'float'
				shade_terminals = true, -- Shades background of terminal

				start_in_insert = true, -- Start in insert mode for terminals
				insert_mappings = true, -- Apply open mapping in insert mode
				terminal_mappings = true, -- Apply open mapping in terminal mode
			})

			-- Custom keybinding to create a new terminal easily
			vim.api.nvim_set_keymap("n", "<C-t>", ":ToggleTerm<CR>", { noremap = true, silent = true })

			-- Move to next tab using Ctrl+Right
			vim.api.nvim_set_keymap("n", "<C-Right>", ":tabnext<CR>", { noremap = true, silent = true })

			-- Move to previous tab using Ctrl+Left
			vim.api.nvim_set_keymap("n", "<C-Left>", ":tabprev<CR>", { noremap = true, silent = true })

			-- Open terminal 1 with Ctrl+t
			vim.api.nvim_set_keymap(
				"n",
				"<C-t>",
				":lua require('toggleterm').toggle(1)<CR>",
				{ noremap = true, silent = true }
			)

			-- Open terminal 2 with Ctrl+y
			vim.api.nvim_set_keymap(
				"n",
				"<C-y>",
				":lua require('toggleterm').toggle(2)<CR>",
				{ noremap = true, silent = true }
			)

			-- Open terminal 3 with Ctrl+u
			vim.api.nvim_set_keymap(
				"n",
				"<C-u>",
				":lua require('toggleterm').toggle(3)<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
	-- LSP and Autocompletion
	{ "williamboman/mason.nvim", lazy = true },
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

	{ "L3MON4D3/LuaSnip", lazy = true },

	{ "nvim-pack/nvim-spectre", lazy = true },

	{ "tpope/vim-fugitive", lazy = true },

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

	-- Multiple cursor
	{
		"mg979/vim-visual-multi",
		branch = "master",
		lazy = true,
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
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
})

-- ///////////////////////////////////////////////////

-- VS code colorscheme
require("vscode").setup({
	-- Alternatively set style in setup
	-- style = 'light'

	-- Enable transparent background
	transparent = false,

	-- Enable italic comment
	italic_comments = false,

	-- Underline `@markup.link.*` variants
	underline_links = true,

	-- Disable nvim-tree background color
	disable_nvimtree_bg = false,

	-- Override colors (see ./lua/vscode/colors.lua)
	color_overrides = {},

	-- Override highlight groups (see ./lua/vscode/theme.lua)
	group_overrides = {},
})

-- ////////////////////////////////////////////////////////

-- nightfox colorscheme
require("nightfox").setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = false, -- Disable setting background
		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = false, -- Non focused panes set to alternative background
		module_default = true, -- Default enable value for modules
		colorblind = {
			enable = false, -- Enable colorblind support
			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 0, -- Severity [0,1] for protan (red)
				deutan = 0, -- Severity [0,1] for deutan (green)
				tritan = 0, -- Severity [0,1] for tritan (blue)
			},
		},
		styles = { -- Style to be applied to different syntax groups
			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		inverse = {
			match_paren = false,
			visual = false,
			search = false,
		},
		modules = {
			-- ...
		},
	},
	palettes = {},
	specs = {},
	groups = {},
})

-------------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------

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

-- /////////////////////////////////////////

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ////////////////////////////////////////////////

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
	-- Add default values for new required fields (if applicable)
	did_setup = nil, -- Function called after setup (optional)
	setup = nil, -- Function to customize setup behavior (optional)
	get_opts = nil, -- Function to get options dynamically
})
