require("nvim-web-devicons").setup({})

require("telescope").setup({})
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Live Search" })

require("flash").setup({
	modes = {
		search = { enabled = true },
	},
})
vim.keymap.set("n", "<leader>ms", function()
	require("flash").treesitter()
end, { desc = "Interactive Select" })
vim.keymap.set("n", "<leader>mS", function()
	require("flash").treesitter_search()
end, { desc = "Interactive Search & Select" })
