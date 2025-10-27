require("nvim-web-devicons").setup({})

require("telescope").setup({
	pickers = {
		keymaps = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
	},
	extensions = {
		resession = {
			prompt_title = "Find Sessions",
			dir = "session",
		},
	},
})
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Find in current project" })
vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymap palette" })

require("flash").setup({
	modes = {
		search = { enabled = true },
	},
})
vim.keymap.set("n", "<leader>ms", function()
	require("flash").treesitter()
end, { desc = "Begin interactive selection" })
vim.keymap.set("n", "<leader>mS", function()
	require("flash").treesitter_search()
end, { desc = "Begin interactive search & selection" })
