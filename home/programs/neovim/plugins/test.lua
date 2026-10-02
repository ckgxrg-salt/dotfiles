require("neotest").setup({
	adapters = {
		require("rustaceanvim.neotest"),
	},
})
vim.keymap.set("n", "<leader>rt", function()
	require("neotest").run.run()
end, { desc = "Run Nearest Test" })
vim.keymap.set("n", "<leader>rf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run Tests in this File" })
vim.keymap.set("n", "<leader>rs", require("neotest").summary.toggle, { desc = "Test Summary" })
vim.keymap.set("n", "<leader>ro", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Test Output" })
