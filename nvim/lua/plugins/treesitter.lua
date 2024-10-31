require'nvim-treesitter.configs'.setup {
   ensure_installed = { "c", "cpp", "lua", "rust", "make", "cmake", "vim", "java"},
   sync_install = false,
   auto_install = true,
   highlight = {
      enable = true,
   },
}
