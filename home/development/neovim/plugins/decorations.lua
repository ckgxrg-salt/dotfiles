if not vim.g.neovide then
	require("smear_cursor").setup({
		damping = 0.95,
		damping_insert_mode = 0.95,
		distance_stop_animating = 0.5,
		stiffness = 0.8,
		stiffness_insert_mode = 0.7,
		trailing_stiffness = 0.5,
		trailing_stiffness_insert_mode = 0.7,
	})
end

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
