-- Do not yank on delete --
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "ce", '"_ce')

vim.keymap.set("v", "d", '"_d')
-- vim.keymap.set("v", "x", '"_x')

-- Split navigation --
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window", silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- Switch buffers
-- vim.keymap.set("n", "<M-h>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
-- vim.keymap.set("n", "<M-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })
