return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
}
