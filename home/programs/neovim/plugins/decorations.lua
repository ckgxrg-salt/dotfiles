require("tiny-glimmer").setup({
	overwrite = {
		search = { enabled = true },
		undo = { enabled = true },
		redo = { enabled = true },
	},
})

require("neoscroll").setup({
	stop_eof = false,
})

require("hlchunk").setup({
	chunk = {
		chars = {
			horizontal_line = "─",
			vertical_line = "│",
			left_top = "┌",
			left_bottom = "└",
			right_arrow = "─",
		},
		enable = true,
	},
	indent = { enable = false },
	line_num = { enable = true },
})

require("illuminate").configure({
	providers = { "lsp", "treesitter", "regex" },
	under_cursor = true,
})
