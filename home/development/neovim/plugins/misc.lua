require("nvim-web-devicons").setup({})
require("auto-session").setup({})
require("todo-comments").setup({})

-- undotree does not need setup
vim.keymap.set("n", "<leader>eu", ":UndotreeToggle<CR>", { desc = "Undo tree" })

require("lsp_signature").setup({})
require("flash").setup({})

require("mini.bufremove").setup({})
vim.keymap.set("n", "<leader>w", MiniBufremove.delete, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Close current window" })

require("telescope").setup({
	pickers = {
		keymaps = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
	},
})
vim.keymap.set("n", "<leader>tt", ":Telescope todo-comments<CR>", { desc = "Todo list" })
vim.keymap.set("n", "<leader>tf", ":Telescope live_grep<CR>", { desc = "Find in current project" })
vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymap palette" })
vim.keymap.set("n", "<leader>ts", ":Telescope session-lens<CR>", { desc = "Sessions" })

require("wtf").setup({
	popup_type = "popup",
	provider = "gemini",
	providers = {
		gemini = {
			api_key = function()
				return vim.fn.readfile(os.getenv("XDG_CONFIG_HOME") .. "/sops-nix/secrets/gemini-token")[1]
			end,
			model_id = "gemini-2.5-flash",
		},
	},
	search_engine = "duck_duck_go",
})
vim.keymap.set("v", "<leader>ds", require("wtf").diagnose, { desc = "Diagnose code with AI" })
vim.keymap.set("v", "<leader>dS", require("wtf").search, { desc = "Diagnose code with search" })

require("mini.surround").setup({
	n_lines = 50,
	respect_selection_type = true,
})

require("nvim-autopairs").setup({
	check_ts = true,
	map_cr = true,
})

-- direnv.vim does not need setup
vim.g.direnv_silent_load = 1

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
