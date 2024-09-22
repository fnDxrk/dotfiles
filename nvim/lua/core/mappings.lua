-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree left reveal<CR>')
vim.keymap.set('n', '<leader>o', ':Neotree float git_status<CR>')


-- Compiler
-- Open compiler
vim.api.nvim_set_keymap('n', '<F5>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Toggle compiler results 
-- <F17> -> <S-F5>
vim.api.nvim_set_keymap('n', '<F17>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })


