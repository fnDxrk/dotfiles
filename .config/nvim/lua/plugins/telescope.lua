return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        border = true,
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "fd", "--type", "f", "-E", ".git" },
        },
        buffers = {
          -- sort_mru = true,
          ignore_current_buffer = true,
        },
      },
    })
    telescope.load_extension("fzf")
  end,
}
