vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- Neo-tree --
vim.keymap.set('n', '<leader>e', ':Neotree filesystem left reveal toggle<CR>', {})
