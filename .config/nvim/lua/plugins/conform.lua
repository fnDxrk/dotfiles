return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      cpp = { "clang-format" },
      c = { "clang-format" },
      bash = { "shfmt" },
    },
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
    },
  },
}
