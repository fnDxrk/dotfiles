return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      --      ensure_installed = {
      --        "lua",
      --        "c",
      --        "cpp",
      --        "c_sharp",
      --        "bash",
      --        "kotlin",
      --        "make"
      --      },
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
