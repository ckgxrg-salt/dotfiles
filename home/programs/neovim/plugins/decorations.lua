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
