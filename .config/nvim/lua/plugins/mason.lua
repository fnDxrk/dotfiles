return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua --
					"lua_ls",
					"stylua",

					-- C/C++ --
					"clangd",
					"clang-format",

					-- Python --
					"pyright",
					"ruff",
				},
			})
		end,
	},
}
