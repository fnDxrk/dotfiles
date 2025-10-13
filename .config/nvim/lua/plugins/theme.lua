return {
	--  {
	--    "EdenEast/nightfox.nvim",
	--    priority = 1000,
	--    opts = {
	--      options = {
	--        transparent = true,
	--      },
	--    },
	--    config = function(_, opts)
	--      require("nightfox").setup(opts)
	--      vim.cmd.colorscheme("nightfox")
	--    end,
	--  },
	--	{
	--		"folke/tokyonight.nvim",
	--		opts = {
	--			style = "storm",
	--			transparent = true,
	--		},
	--		config = function(_, opts)
	--			require("tokyonight").setup(opts)
	--		end,
	--	},
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
		opts = {
			flavour = "mocha",
			transparent_background = true,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
