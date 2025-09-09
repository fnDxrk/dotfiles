return {
  -- Theme  
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme carbonfox]])
    end,
  },

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
  },
}
