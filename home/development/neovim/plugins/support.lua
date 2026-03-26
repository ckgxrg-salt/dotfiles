require("which-key").setup({
	preset = "modern",
	spec = {
		{ "<leader>e", group = "Editor", icon = " " },
		{ "<leader>m", group = "Motion", icon = "󱖳 " },
		{ "<leader>c", group = "Actions", icon = "󰲒 " },
		{ "<leader>n", group = "Document", icon = "󰠮 " },
		{ "<leader>t", group = "List", icon = "󰭎 " },
		{ "<leader>d", group = "Run", icon = " ", mode = { "n", "v" } },
		{ "<leader>r", group = "Test", icon = "󰙨 " },
	},
})
vim.keymap.set({ "n", "v", "i" }, "<F1>", ":WhichKey<CR>", { desc = "Show keymaps" })
