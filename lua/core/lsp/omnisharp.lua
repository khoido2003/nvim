-- lsp/omnisharp.lua
local lspconfig = require('lspconfig')

lspconfig.omnisharp.setup({
  cmd = { "omnisharp" },
  filetypes = { "cs" },
  root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
  settings = {
    omnisharp = {
      enableRoslynAnalyzers = true,
      enableEditorConfigSupport = true,
      enableMsBuildLoadProjectsOnDemand = true,
    }
  },
})
