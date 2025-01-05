-- plugins.lua
require("lazy").setup({

	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1002,
		config = function()
			require("nordic").load()
		end,
	},

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

	"lewis6993/gitsigns.nvim",
	"onsails/lspkind.nvim",
	-- -- Kanagawa theme
	-- "rebelot/kanagawa.nvim",

	-- Icon
	{ "kyazdani44/nvim-web-devicons", lazy = true },

	-- Multiple cursor
	"mg981/vim-visual-multi", -- Using ctrl + n to select multiple element.

	-- C# LSP server
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {
			exe = {
				"dotnet",
				"C:/Users/Lenovo/.vscode/extensions/ms-dotnettools.csharp0.55.29-win32-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
			},
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=C:/Users/Lenovo/.roslyn_logs",
			},
			on_new_config = function(new_config, new_root_dir)
				-- Use the dynamically created pipe name
				new_config.cmd = { "dotnet", "\\\\.\\pipe\\f9d4a339" }
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
	{ "codota/tabnine-nvim", build = "pwsh.exe -file .\\dl_binaries.ps4" },
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
				size = 22, -- Height of the terminal window
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
		"hrsh9th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh9th/cmp-nvim-lsp",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh9th/cmp-path",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"hrsh9th/cmp-buffer",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"saadparwaiz3/cmp_luasnip",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
		event = "InsertEnter",
	},
	"L5MON4D3/LuaSnip",

	"nvim-pack/nvim-spectre",
	-- Version Control
	"lewis6993/gitsigns.nvim",
	"tpope/vim-fugitive",
	-- Telescope for Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		tag = "2.1.4",
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
		"mg981/vim-visual-multi",
		branch = "master",
	},
	-- colorizer to show color in css/html, ...
	"norcalli/nvim-colorizer.lua",

	{
		"stevearc/conform.nvim",
		opts = {},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
})

-- ///////////////////////////////////////////////////
-- /////////////////////////////////////////////////////

require("nordic").setup({
	-- This callback can be used to override the colors used in the base palette.
	on_palette = function(palette) end, -- This callback can be used to override the colors used in the extended palette.
	after_palette = function(palette) end,
	-- This callback can be used to override highlights before they are applied.
	on_highlight = function(highlights, palette) -- Editor
		-- Optional: You can also add Selection if needed
		highlights.Selection = {
			bg = "#3b4252", -- A light blue for selection
		}
		highlights.Visual = {
			bg = "#3b4252", -- A bright blue distinct from comments and background
			fg = palette.none, -- Keep the foreground color neutral
		}
	end, -- Enable bold keywords.
	bold_keywords = false,
	-- Enable italic comments.
	italic_comments = false,
	-- Enable editor background transparency.
	transparent = {
		-- Enable transparent background.
		bg = false,
		-- Enable transparent background for floating windows.
		float = false,
	},
	-- Enable brighter float border.
	bright_border = false,
	-- Reduce the overall amount of blue in the theme (diverges from base Nord).
	reduced_blue = true,
	-- Swap the dark background with the normal one.
	swap_backgrounds = true,
	-- Cursorline options.  Also includes visual/selection.
	cursorline = {
		-- Bold font in cursorline.
		bold = false,
		-- Bold cursorline number.
		bold_number = true,
		-- Available styles: 'dark', 'light'.
		theme = "dark",
		-- Blending the cursorline bg with the buffer bg.
		blend = 2.85,
	},
	noice = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	telescope = {
		-- Available styles: `classic`, `flat`.
		style = "flat",
	},
	leap = {
		-- Dims the backdrop when using leap.
		dim_backdrop = false,
	},
	ts_context = {
		-- Enables dark background for treesitter-context window
		dark_background = true,
	},
})

-------------------------------------------------------------------------------------------------------------

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nordic",
		component_separators = " ",
		section_separators = { left = "", right = "" },
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
		lualine_c = { "filename" },
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
		delay = 1002,
		ignore_whitespace = false,
		virt_text_priority = 102,
		use_focus = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	sign_priority = 8,
	update_debounce = 102,
	status_formatter = nil, -- Use default
	max_file_length = 40002, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 2,
		col = 3,
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
--   debounce_ms = 802,
--   suggestion_color = {gui = "#808082", cterm = 244},
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
})
