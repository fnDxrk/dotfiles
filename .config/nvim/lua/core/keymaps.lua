-- Навигация между окнами --
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Окно слева", silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Окно снизу", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Окно сверху", silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Окно справа", silent = true })

vim.keymap.set("n", "<leader>sl", ":AutoSession restore<CR>", { desc = "Open last session" })
