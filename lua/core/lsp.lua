local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Ensure the LSP servers are installed
mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "pyright", "ts_ls", "gopls", "clangd", "jdtls", "omnisharp", "html", "cssls", "yamlls", "tailwindcss" }, -- Correct server names
})

-- Set up LSP keymaps and capabilities
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  
  -- Enable completion with nvim-cmp
  require('cmp').setup.buffer { sources = { { name = 'nvim_lsp' } } }
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure individual LSP servers
lspconfig.pyright.setup { on_attach = on_attach, capabilities = capabilities }

lspconfig.ts_ls.setup { on_attach = on_attach, capabilities = capabilities }

lspconfig.clangd.setup { on_attach = on_attach, capabilities = capabilities }

lspconfig.dockerls.setup({
  cmd = { "docker-langserver", "--stdio" },
})

-- Setup yamlls (YAML Language Server)
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        -- Correct Kubernetes schema URL from the official Kubernetes repository
        ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "*.yaml",  -- Kubernetes schema
      },
    },
  },
})

-- Go LSP
require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,  -- Detect unused parameters in your code
        shadow = true,        -- Detect shadowed variables
        fieldalignment = true, -- Align struct fields
        nilness = true,       -- Detect nil pointer dereferencing
      },
      staticcheck = true,     -- Enable staticcheck for advanced linting
      semanticTokens = true,  -- Enable semantic tokens for better syntax highlighting
      -- You can now remove the `format` setting here, as gopls handles this differently
    },
  },

  on_attach = function(client, bufnr)
    -- Disable the default formatting in LSP (we will configure it separately)
    client.server_capabilities.documentFormattingProvider = true
    -- Configure keybindings
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
  end,
}

-- Auto format on save for Go files
vim.cmd([[
  augroup GoLsp
    autocmd!
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
  augroup END
]])


-- /////////////////////////////////////////////////

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

-- ////////////////////////////////////////////////////////////////////

require'lspconfig'.tailwindcss.setup{
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
}


-- ///////////////////////////////////////////

-- -- Set up LSP for Java with nvim-jdtls
local lspconfig = require'lspconfig'

lspconfig.jdtls.setup{
  cmd = { 'jdtls' },  -- You can use the path if necessary
  root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
  settings = {
    java = {
      -- Optional: You can add specific Java settings here
    }
  }
}

