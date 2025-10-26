require("todo-comments").setup({})
vim.keymap.set("n", "<leader>tt", ":Telescope todo-comments<CR>", { desc = "Todo list" })

require("lsp_signature").setup({})

require("mini.bufremove").setup({})
vim.keymap.set("n", "<leader>w", MiniBufremove.delete, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Close current window" })

require("mini.surround").setup({
	n_lines = 50,
	respect_selection_type = true,
})

require("nvim-autopairs").setup({
	check_ts = true,
	map_cr = true,
})

require("gitsigns").setup({
	attach_to_untracked = true,
	auto_attach = true,
	current_line_blame = true,
	current_line_blame_formatter = " <author>, <author_time> - <summary> ",
})

require("indent-o-matic").setup({
	max_lines = 512,
	standard_widths = { 2, 4, 8 },
	skip_multiline = true,
})
