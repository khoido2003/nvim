local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- -- Java LSP (jdtls) requires a separate setup
-- require('core.lsp.jdtls') -- Ensure the file exists and contains the proper configuration

-- -- C# LSP (omnisharp) requires a separate setup
-- require('core.lsp.omnisharp') -- Ensure the file exists and contains the proper configuration

-- Ensure the LSP servers are installed
mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "pyright", "ts_ls", "gopls", "clangd", "jdtls", "omnisharp" }, -- Correct server names
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
lspconfig.gopls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.clangd.setup { on_attach = on_attach, capabilities = capabilities }


lspconfig.omnisharp.setup({
  cmd = { "omnisharp" }, -- Ensure omnisharp is in your PATH
  filetypes = { "cs" },
  root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
  
})

lspconfig.jdtls.setup({
  cmd = { "jdtls" }, -- Ensure this path matches your jdtls installation
  filetypes = { "java" },
  root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle", ".project"),
  settings = {
    java = {
      format = {
        enabled = true,
      },
    },
  },
})

