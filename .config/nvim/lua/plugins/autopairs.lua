return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	opts = {},
	keys = {
		vim.keymap.set("n", "<leader>sl", ":AutoSession restore<CR>", { desc = "Open last session" }),
	},
}
