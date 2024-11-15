-- nvim-cmp setup
local cmp = require'cmp'
local lspkind = require('lspkind')  -- To show icons in completion menu

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- Expand snippets using LuaSnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),  -- Scroll documentation
    ['<C-f>'] = cmp.mapping.scroll_docs(4),   -- Scroll documentation
    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
    ['<C-e>'] = cmp.mapping.close(),         -- Close completion menu
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
  }),
  sources = {
    { name = 'nvim_lsp' },  -- LSP completion source
    { name = 'luasnip' },    -- Snippet source
    { name = 'path' },       -- Path completion source
    { name = 'buffer' },     -- Buffer completion source
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
    }),  -- Use lspkind to show icons in the completion menu
  },
})
