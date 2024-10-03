local lspconfig = require('lspconfig')
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup({
    filetypes = { 'cmake', 'CMakeLists.txt' },
})

