return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    local langs = {
      "lua",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "xml",
      "cpp",
      "c",
      "python",
      "rust",
      "cmake",
      "make",
    }

    ts.install(langs):wait(60000)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
