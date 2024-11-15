-- lsp/jdtls.lua
local lspconfig = require('lspconfig')

lspconfig.jdtls.setup({
  cmd = { "jdtls" },
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
