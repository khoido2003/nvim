-- lsp/jdtls.lua

-- init.lua or lsp_config.lua (wherever you configure LSPs)
local jdtls = require('jdtls')

-- Set root directory for the Java project
local root_dir = jdtls.setup.find_root({'.git', 'pom.xml', 'build.gradle', 'settings.gradle'})

-- Path to the JDTLS launcher jar file (this is usually installed by Mason or manually installed)
local jdtls_jar = vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'

-- Path to the configuration directory (make sure it's correct for your setup)
local config_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_win'

-- Workspace directory where your Java workspace will be stored
local workspace_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls/workspace'

-- Java LSP config (set Java home, paths, and other settings)
local config = {
  cmd = {
    'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dfile.encoding=UTF-8',
    '-jar', jdtls_jar,
    '-configuration', config_dir,
    '-data', workspace_dir
  },
  root_dir = root_dir,
  settings = {
    java = {
      home = 'C:/Program Files/Java/jdk-22'',  -- Path to your JDK, e.g., 'C:/Program Files/Java/jdk-22'
    }
  }
}

-- Start the JDTLS server for Java files
jdtls.start_or_attach(config)
