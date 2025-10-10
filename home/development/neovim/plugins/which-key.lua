require("which-key").setup({
	preset = "modern",
	spec = {
		{ "<leader>e", group = "Editor", icon = " " },
		{ "<leader>c", group = "Code Actions", icon = "󰲒 " },
		{ "<leader>t", group = "Telescope", icon = "󰭎 " },
		{ "<leader>d", group = "Debug", icon = " " },
		{ "<leader>r", group = "Test", icon = "󰙨 " },
		{ "<leader>n", group = "Notebook", icon = "󰠮 " },
	},
})

vim.keymap.set({ "n", "v", "i" }, "<F1>", ":WhichKey<CR>", { desc = "Show keymaps" })
