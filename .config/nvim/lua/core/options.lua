-- Clipboard --
vim.opt.clipboard = "unnamedplus"

-- SSH clipboard
if vim.env.SSH_CLIENT or vim.env.SSH_TTY or vim.env.WEZTERM_EXECUTABLE then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- Line numbers --
vim.opt.number = true
vim.opt.relativenumber = true

-- Text display --
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Indentation --
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search --
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Colors and UI --
vim.opt.termguicolors = true
vim.opt.pumheight = 10

-- Window splitting --
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Files --
vim.opt.swapfile = false

-- Whitespace --
vim.opt.list = false

vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  space = "·",
}

local code_fts = { "lua", "py", "rust", "c", "cpp", "js", "ts", "sh", "sql" }
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end
    if vim.fn.mode():match("[vV\x16]") and vim.tbl_contains(code_fts, vim.bo.filetype) then
      vim.opt.list = true
    else
      vim.opt.list = false
    end
    require("ibl").update()
  end,
})


-- Wildmenu
-- Потом нужно заменить на nvim-cmp и cmp-path
vim.keymap.set('c', '<CR>', function()
  if vim.fn.wildmenumode() == 1 then
    return '<C-Y>'
  else
    return '<CR>'
  end
end, { expr = true, silent = true })
