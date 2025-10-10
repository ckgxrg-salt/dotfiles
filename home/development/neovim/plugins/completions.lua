require("blink-cmp").setup({
	cmdline = {
		completion = {
			ghost_text = { enabled = false },
		},
	},
	completion = {
		accept = { dot_repeat = false },
		documentation = { auto_show = true },
		list = { selection = { preselect = false } },
	},
	keymap = {
		["<C-Tab>"] = { "show" },
		["<CR>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
	},
	signature = { enabled = true },
})
