require("neotest").setup({
	adapters = {
		require("rustaceanvim.neotest"),
	},
})

vim.keymap.set("n", "<leader>rt", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>rf", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>rs", require("neotest").summary.toggle, { desc = "Show tests summary" })
vim.keymap.set("n", "<leader>ro", function() require("neotest").output.open({ enter = true }) end, { desc = "Show tests summary" })
