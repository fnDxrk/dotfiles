return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	---@module 'neo-tree'
	---@type neotree.Config
	opts = {
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			use_libuv_file_watcher = true,
		},
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
		window = {
			mappings = {
				["O"] = "expand_all_nodes",
				["C"] = "close_all_nodes",
			},
		},
	},
	keys = {
		{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
	},
}
