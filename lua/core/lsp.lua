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
  ensure_installed = { "pyright", "ts_ls", "gopls", "clangd", "jdtls", "omnisharp", "html", "cssls", "yamlls" }, -- Correct server names
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

-- Configure dockerls for Dockerfile
lspconfig.dockerls.setup{}


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


-- Function to start OmniSharp asynchronously
local function start_omnisharp()
  -- Setup OmniSharp LSP without delay
  lspconfig.omnisharp.setup({
    cmd = {
      "omnisharp",
      "--languageserver",
      "--hostPID", tostring(vim.fn.getpid())
    },
    filetypes = { "cs" },
    root_dir = lspconfig.util.root_pattern(".git", "*.sln", "*.csproj"),
    autostart = true,
    handlers = {
      ["textDocument/inlayHint"] = function() end, -- Disable inlay hints
    },
    on_attach = function(client, bufnr)
      -- Custom on_attach logic (if needed)
    end,
  })
end

-- Start OmniSharp without delay
start_omnisharp()


-- ///////////////////////////////////////////

-- -- Set up LSP for Java with nvim-jdtls
-- local lspconfig = require('lspconfig')
-- lspconfig.jdtls.setup {
--     cmd = {
--         "java-ls",  -- the LSP server, you can modify if needed
--         "-data", vim.fn.stdpath('data').."/lsp_servers/jdtls/workspace"
--     },
--     settings = {
--         java = {
--             configuration = {
--                 -- Java-specific settings
--             },
--         },
--     },
--     on_attach = function(client, bufnr)
--         -- You can add custom on_attach functionality here
--         -- for example, to enable formatting
--         if client.resolved_capabilities.document_formatting then
--             vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')
--         end
--     end,
-- }
