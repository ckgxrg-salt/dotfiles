require("nvim-web-devicons").setup({})

require("telescope").setup({
	pickers = {
		keymaps = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
	},
})
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Find in current project" })
vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymap palette" })
