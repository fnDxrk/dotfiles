return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  config = true,
  lazy = false,
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory" },
  },
  config = function()
    require("oil").setup({
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["<Esc>"] = { "actions.close", mode = "n" },
      },
      float = {
        max_width = 0.4,
        max_height = 0.4,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        get_win_title = function(winid)
          local bufnr = vim.api.nvim_win_get_buf(winid)
          local dir = require("oil").get_current_dir(bufnr)
          if dir then
            return "  " .. vim.fn.fnamemodify(dir, ":~")
          end
          return "Oil"
        end,
      },
    })
  end,
}
