-- plugins.lua

require("lazy").setup({
  
  "lewis6991/gitsigns.nvim",
  "onsails/lspkind.nvim",
 
  -- Commenting plugin
  "numToStr/Comment.nvim",
  
 -- UI Enhancements
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "ellisonleao/gruvbox.nvim",

  -- Tabnine AI
  { 'codota/tabnine-nvim', build = "pwsh.exe -file .\\dl_binaries.ps1" },

  -- Syntax Highlighting and Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opts = {
      ensure_installed = { "c_sharp", "go", "java", "typescript", "javascript", "html", "css", "lua", "json", "markdown", "python" },
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

  -- Typescript
  "pmizio/typescript-tools.nvim",
  
  'nvim-pack/nvim-spectre',
  
  -- vimline
  'nvim-lualine/lualine.nvim',

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

	-- -- JAVA LSP
	-- 'williamboman/mason.nvim',
	-- 'williamboman/mason-lspconfig.nvim',

  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-vsnip'
})

-- ///////////////////////////////////////////////////
-- /////////////////////////////////////////////////////

-- CONFIGURATIONS

-- telescope.nvim setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/*", "*.log" }, -- Ignore specific files or directories
  },
}


-- /////////////////////////////////////////////////////////////

-- nvim-tree setup
require("nvim-tree").setup({
 
  sync_root_with_cwd = true, -- Sync the tree with the current working directory
  update_cwd = true, -- Update the tree when you change directories
  hijack_netrw = true,  
  reload_on_bufenter = true, 
})

-- //////////////////////////////////////////////////////

-- GIT Support
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

-- ////////////////////////////////////////////////////

-- LUA line

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}



-- /////////////////////////////////////////////

-- LSP Setup for omnisharp
require("lspconfig")["omnisharp"].setup({
  on_attach = function(client, bufnr)
    -- Enable format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
      
      -- Auto format on save
      vim.cmd([[
        augroup format_on_save
          autocmd!
          autocmd BufWritePre *.cs lua vim.lsp.buf.format({ async = true })
        augroup END
      ]])
    end
  end,
})

-- ///////////////////////////////

-- LSP for typescript
require("typescript-tools").setup {
  on_attach = function(client, bufnr)
    -- Auto-format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
      vim.cmd([[
        augroup format_on_save
          autocmd!
          autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx lua vim.lsp.buf.format({ async = true })
        augroup END
      ]])
    end
  end,
  handlers = {
    -- Customize handlers here if needed
  },
  settings = {
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_locale = "en",
    tsserver_plugins = {}, -- Specify any plugins here
  }
}

-- /////////////////////////////////////////////

require('lspconfig').pyright.setup({
  on_attach = function(client, bufnr)
    -- Enable format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
      
      -- Auto format on save
      vim.cmd([[
        augroup format_on_save
          autocmd!
          autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = true })
        augroup END
      ]])
    end
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- Options: off | basic | strict
        autoSearchPaths = true,      -- Automatically add search paths
        useLibraryCodeForTypes = true,  -- Use the library code for type checking
      },
    },
  },
})

-- //////////////////////////////////////

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


require("lspconfig").html.setup {
  cmd = { "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\mason\\bin\\vscode-html-language-server.cmd", "--stdio" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
      -- Enable auto-format on save
      if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
          -- Auto-format on save
          vim.cmd([[
              augroup AutoFormat
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })
              augroup END
          ]])
      end
  end,
}
require("lspconfig").cssls.setup {
  cmd = { "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\mason\\bin\\vscode-css-language-server.cmd", "--stdio" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
      -- Enable auto-format on save
      if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
          -- Auto-format on save
          vim.cmd([[
              augroup AutoFormat
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })
              augroup END
          ]])
      end
  end,
}

-- Example for integrating Prettier with null-ls for HTML and CSS formatting
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.prettier.with({
      filetypes = { "html", "css", "scss" },
    }),
  },
})

-- ////////////////////////////////////////////////////////////////////


require("lspconfig").tailwindcss.setup({
  on_attach = function(client, bufnr)
    -- Add your LSP keybindings and auto-formatting setup here
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})


-- ////////////////////////////////////////////////

require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
})