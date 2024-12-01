-- plugins.lua

require("lazy").setup({

  { "rose-pine/neovim", name = "rose-pine" },
  'marko-cerovac/material.nvim',
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  
  "lewis6991/gitsigns.nvim",
  "onsails/lspkind.nvim",

  -- Kanagawa theme
  "rebelot/kanagawa.nvim",
  
  -- Icon
  { "kyazdani42/nvim-web-devicons" },
 
  -- Commenting plugin
  "numToStr/Comment.nvim",

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
            },
        },
    }
    
  },

  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",

  -- Auto close {}
  "windwp/nvim-autopairs",

  -- Tabnine AI
  { 'codota/tabnine-nvim', build = "pwsh.exe -file .\\dl_binaries.ps1" },

  -- Syntax Highlighting and Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opts = {
      ensure_installed = { "c_sharp", "go", "java", "typescript", "javascript", "html", "css", "lua", "json", "markdown", "python" },
      highlight = { enable = true,additional_vim_regex_highlighting = false, },
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
  
  -- Version Control
  "lewis6991/gitsigns.nvim",

  "tpope/vim-fugitive",

  -- Web Development Tools
  "mattn/emmet-vim",
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
  },

  -- Telescope for Fuzzy Finding
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Language Specific Tools
  {
    'OmniSharp/omnisharp-vim'
  },
  {
    "fatih/vim-go", -- Go development
    run = ":GoUpdateBinaries",
  },
  {
    "jose-elias-alvarez/null-ls.nvim", -- Linting and Formatting
    dependencies = { "nvim-lua/plenary.nvim" },
  },

})

-- ///////////////////////////////////////////////////
-- /////////////////////////////////////////////////////

-- CONFIGURATIONS

-- telescope.nvim setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/*", "*.log" }, -- Ignore specific files or directories
  },
  extensions = {
    lsp_handlers = {
        code_action = {
            telescope = require('telescope.themes').get_dropdown({})
        }
    }
  }
}


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
    url = "https://github.com/tree-sitter/tree-sitter-c-sharp",  -- Specify the parser's repo
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  filetype = "cs",
}

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
    theme = {
      normal = {
        a = { fg = '#ffffff', bg = '#2e3238', gui = 'bold' },  -- Normal mode 
        b = { fg = '#c5c8c6', bg = '#202426' },                  -- Background for branch, diagnostics (dark grayish)
        c = { fg = '#c5c8c6', bg = '#202426' },                  -- Background for filename (dark grayish)
      },
      insert = {
        a = { fg = '#ffffff', bg = '#9d7cd8', gui = 'bold' },  -- Insert mode (background dark blue-gray)
      },
      visual = {
        a = { fg = '#ffffff', bg = '#e46876', gui = 'bold' },  -- Visual mode (background muted gray)
      },
      replace = {
        a = { fg = '#ffffff', bg = '#5a6374', gui = 'bold' },  -- Replace mode (background rose red)
      },
      command = {
        a = { fg = '#ffffff', bg = '#364F6B', gui = 'bold' },  -- Command mode (background purple)
      },
      inactive = {
        a = { fg = '#c5c8c6', bg = '#1c1f24' },  -- Inactive sections have a muted gray background
        b = { fg = '#c5c8c6', bg = '#1c1f24' },
        c = { fg = '#c5c8c6', bg = '#1c1f24' },
      },
    },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- /////////////////////////////////////////////

require('lspconfig').util.root_pattern('*.sln', '*.csproj')

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
require('nvim-autopairs').setup({
  check_ts = true,  -- Enable treesitter support
})


-- Configure nvim-web-devicons (you can customize as needed)
require'nvim-web-devicons'.setup {
  default = true,  -- Use default icons for unrecognized filetypes
}


-- Default options:
require('kanagawa').setup({
  compile = false,             -- enable compiling the colorscheme
  undercurl = true,            -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false},
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,         -- do not set background color
  dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
  terminalColors = true,       -- define vim.g.terminal_color_{0,17}
  colors = {                   -- add/modify theme and palette colors
      palette = {},
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors)
    return {
      GitSignsAdd = { bg = "NONE", fg = colors.palette.springGreen }, -- Git add highlight
      GitSignsChange = { bg = "NONE", fg = colors.palette.autumnYellow }, -- Git change highlight
      GitSignsDelete = { bg = "NONE", fg = colors.palette.sakuraPink }, -- Git delete highlight
      DiffAdd = { bg = "NONE", fg = colors.palette.springGreen },
      DiffChange = { bg = "NONE", fg = colors.palette.autumnYellow },
      DiffDelete = { bg = "NONE", fg = colors.palette.sakuraPink },
      DiffText = { bg = "NONE", fg = colors.theme.ui.fg }, -- Remove gray background for unchanged parts
      CursorLine = { bg = colors.theme.ui.bg_p1 }, -- Less bright cursor line
      LineNr = { bg = "NONE" }, -- Remove background from line numbers
      Normal = { bg = "NONE" }, -- Ensure normal text has no background
      NormalNC = { bg = "NONE" }, -- Remove background from inactive windows
      SignColumn = { bg = "NONE" }, -- Remove background from sign column

      -- Remove background for diagnostics
      DiagnosticError = { fg = colors.palette.autumnRed, bg = "NONE" },
      DiagnosticWarn = { fg = colors.palette.autumnYellow, bg = "NONE" },
      DiagnosticInfo = { fg = colors.palette.waveBlue1, bg = "NONE" },
      DiagnosticHint = { fg = colors.palette.springGreen, bg = "NONE" },

      -- Optionally adjust virtual text colors
      DiagnosticVirtualTextError = { fg = colors.palette.autumnRed, bg = "NONE" },
      DiagnosticVirtualTextWarn = { fg = colors.palette.autumnYellow, bg = "NONE" },
      DiagnosticVirtualTextInfo = { fg = colors.palette.waveBlue1, bg = "NONE" },
      DiagnosticVirtualTextHint = { fg = colors.palette.springGreen, bg = "NONE" },

      -- Diagnostic signs (e.g., symbols like H for Hint)
      DiagnosticSignError = { fg = colors.palette.autumnRed, bg = "NONE" },
      DiagnosticSignWarn = { fg = colors.palette.autumnYellow, bg = "NONE" },
      DiagnosticSignInfo = { fg = colors.palette.waveBlue1, bg = "NONE" },
      DiagnosticSignHint = { fg = colors.palette.springGreen, bg = "NONE" },
    }
  end,
  theme = "dragon",              -- Load "wave" theme when 'background' option is not set
  background = {               -- map the value of 'background' option to a theme
      dark = "dragon",           -- try "dragon" !
      light = "lotus"
  },
})

-- //////////////////////////////////////////////////////////////////////////////////////

require('dashboard').setup({
  theme = 'hyper',

  config = {
    header = {
        [[                                          ]],
        [[                                          ]],
        [[                                          ]],
        [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
        [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
        [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
        [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
        [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
        [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
        [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
        [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
        [[     ██║     ██║   ██║██║   ██║██║        ]],
        [[     ██║     ██║   ██║██║   ██║██║        ]],
        [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
        [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
        [[███████╗████████╗██╗   ██╗███████╗███████╗]],
        [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
        [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
        [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
        [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
        [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
        [[                                          ]],
        [[                                          ]],                                         
            },
      
      -- week_header = {
      --  enable = true,
      -- },
      shortcut = {
        { desc = '🌀 Update', group = 'DashboardShortcut', action = 'Lazy update', key = 'u' },
        { desc = "🌙  Find File", group = "DashboardShortcut", action = "Telescope find_files", key = "f" },
        { desc = "🌿  Find Word", group = "DashboardShortcut", action = "Telescope live_grep", key = "w" },
        { desc = "📚  Recent Files", group = "DashboardShortcut", action = "Telescope oldfiles", key = "r" },
        { desc = "❍  Quit", group = "DashboardShortcut", action = ":qa", key = "q" },
      },

      footer = {
        "🌸 Breathe deeply, code calmly 🌸",
    },
  },
})

----/////////////////////////////////////////////////////////////

-- Material color scheme

--Lua:
vim.g.material_style = "darker"

require('material').setup({

  contrast = {
      terminal = false, -- Enable contrast for the built-in terminal
      sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      cursor_line = false, -- Enable darker background for the cursor line
      lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
      non_current_windows = false, -- Enable contrasted background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
  },

  styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { --[[ italic = true ]] },
      strings = { --[[ bold = true ]] },
      keywords = { --[[ underline = true ]] },
      functions = { --[[ bold = true, undercurl = true ]] },
      variables = {},
      operators = {},
      types = {},
  },

  plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      -- "coc",
      -- "colorful-winsep",
      -- "dap",
      -- "dashboard",
      -- "eyeliner",
      -- "fidget",
      -- "flash",
      -- "gitsigns",
      -- "harpoon",
      -- "hop",
      -- "illuminate",
      -- "indent-blankline",
      -- "lspsaga",
      -- "mini",
      -- "neogit",
      -- "neotest",
      -- "neo-tree",
      -- "neorg",
      -- "noice",
      -- "nvim-cmp",
      -- "nvim-navic",
      -- "nvim-tree",
      -- "nvim-web-devicons",
      -- "rainbow-delimiters",
      -- "sneak",
      -- "telescope",
      -- "trouble",
      -- "which-key",
      -- "nvim-notify",
  },

  disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between vertically split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false -- Hide the end-of-buffer lines
  },

  high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false -- Enable higher contrast text for darker style
  },

  lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

  async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

  custom_colors = nil, -- If you want to override the default colors, set this to a function

  custom_highlights = {}, -- Overwrite highlights with your own
})


-- ////////////////////////////////////////////////////////////////

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

          base = '#18191a',
          overlay = '#363738',
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


