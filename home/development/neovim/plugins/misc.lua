require("nvim-web-devicons").setup({})
require("auto-session").setup({})
require("todo-comments").setup({})
-- undotree does not need setup
require("lsp_signature").setup({})
require("flash").setup({})
require("mini.bufremove").setup({})

require("telescope").setup({
	pickers = {
		keymaps = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
	},
})

require("mini.surround").setup({
	n_lines = 50,
	respect_selection_type = true,
})

require("nvim-autopairs").setup({
	check_ts = true,
	map_cr = true,
})

require("smear_cursor").setup({
	damping = 0.95,
	damping_insert_mode = 0.95,
	distance_stop_animating = 0.5,
	stiffness = 0.8,
	stiffness_insert_mode = 0.7,
	trailing_stiffness = 0.5,
	trailing_stiffness_insert_mode = 0.7,
})

require("neoscroll").setup({
	stop_eof = false,
})

require("nvim-lightbulb").setup({
	number = { enabled = true },
	sign = {
		enabled = true,
		lens_text = "",
		text = "",
	},
})

-- direnv.vim does not need setup
vim.g.direnv_silent_load = 1

require("gitsigns").setup({
	attach_to_untracked = true,
	auto_attach = true,
	current_line_blame = true,
	current_line_blame_formatter = " <author>, <author_time> - <summary> ",
})

require("guess-indent").setup({ auto_cmd = true })

vim.keymap.set("n", "<leader>w", MiniBufremove.delete, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>eu", ":UndotreeToggle<CR>", { desc = "Undo tree" })
vim.keymap.set("n", "<leader>tt", ":Telescope todo-comments<CR>", { desc = "Todo list" })
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Find in current project" })
vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymap palette" })
vim.keymap.set("n", "<leader>ts", ":Telescope session-lens<CR>", { desc = "Sessions" })
