-- Leader клавиши --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Автоматическая смена рабочей директории на директорию открытого файла --
vim.opt.autochdir = true

-- Ограничение высоты всплывающего меню -- 
vim.opt.pumheight = 15

-- Буфер обмена --
vim.opt.clipboard = "unnamedplus"

-- Отключение swapfile --
vim.opt.swapfile = false

-- Нумерация строк --
vim.opt.number = true
vim.opt.relativenumber = true

-- Отступы --
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Поиск --
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Внешний вид --
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Разделение окон --
vim.opt.splitright = true
vim.opt.splitbelow = true
