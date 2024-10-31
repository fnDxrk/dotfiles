local lspconfig = require('lspconfig')

require('java').setup()

require'lspconfig'.pyright.setup({})
require'lspconfig'.clangd.setup({})
require'lspconfig'.jdtls.setup({})
require'lspconfig'.cmake.setup({
    filetypes = { 'cmake', 'cmakelists.txt' },
})

