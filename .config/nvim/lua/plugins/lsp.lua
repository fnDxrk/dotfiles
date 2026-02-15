return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      severity_sort = true,
      float = { border = "rounded" },
    })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
  end,
}
