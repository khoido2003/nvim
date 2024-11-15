-- plugins.lua
require("lazy").setup({
  "lewis6991/gitsigns.nvim",
  "onsails/lspkind.nvim",
  -- UI Enhancements
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "ellisonleao/gruvbox.nvim",

  -- Syntax Highlighting and Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opts = {
      ensure_installed = { "c_sharp", "go", "java", "typescript", "javascript", "html", "css", "lua", "json", "markdown" },
      highlight = { enable = true },
    },
  },

    -- Terminal management
    {
      "akinsho/toggleterm.nvim",
      version = "*", -- Optional: use the latest version
      config = function()
        require("toggleterm").setup({
          size = 20, -- Height of the terminal window
          open_mapping = [[<c-\>]], -- Shortcut to toggle the terminal
          direction = "float", -- Options: 'horizontal', 'vertical', 'tab', 'float'
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
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- Debugging
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- Version Control
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",

  -- Web Development Tools
  "mattn/emmet-vim",
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
  },
  {
    "vinnymeller/swagger-preview.nvim",
    run = "npm install -g swagger-ui-watcher",
  },

  -- Telescope for Fuzzy Finding
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Language Specific Tools
  {
    "Hoffs/omnisharp-extended-lsp.nvim", -- C# support
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "fatih/vim-go", -- Go development
    run = ":GoUpdateBinaries",
  },
  {
    "mfussenegger/nvim-jdtls", -- Java development
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "jose-elias-alvarez/null-ls.nvim", -- Linting and Formatting
    dependencies = { "nvim-lua/plenary.nvim" },
  },
})

-- telescope.nvim setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/*", "*.log" }, -- Ignore specific files or directories
  },
}

-- nvim-tree setup
require("nvim-tree").setup({
 
  update_cwd = true, 
  hijack_netrw = true,  
})

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
