require("which-key").setup({
	preset = "modern",
	spec = {
		{ "<leader>e", group = "Editor", icon = " " },
		{ "<leader>c", group = "Code Actions", icon = "󰲒 " },
		{ "<leader>t", group = "List", icon = "󰭎 " },
		{ "<leader>d", group = "Debug", icon = " ", mode = { "n", "v" } },
		{ "<leader>r", group = "Test", icon = "󰙨 " },
		{ "<leader>n", group = "Document", icon = "󰠮 " },
		{ "<leader>m", group = "Motion", icon = "󱖳 " },
	},
})
vim.keymap.set({ "n", "v", "i" }, "<F1>", ":WhichKey<CR>", { desc = "Show keymaps" })
