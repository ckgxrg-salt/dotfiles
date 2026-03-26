require("nvim-web-devicons").setup({})

require("telescope").setup({})
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Find in current project" })
vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymap palette" })

require("flash").setup({
	modes = {
		search = { enabled = true },
	},
})
vim.keymap.set("n", "<leader>ms", function()
	require("flash").treesitter()
end, { desc = "Interactive select" })
vim.keymap.set("n", "<leader>mS", function()
	require("flash").treesitter_search()
end, { desc = "Interactive search & select" })
