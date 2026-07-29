require("trouble").setup({
	warn_no_results = true,
})
vim.keymap.set("n", "<leader>cd", ":Trouble diagnostics toggle<CR>", { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>cf", ":Trouble lsp_definitions toggle<CR>", { desc = "Show definitions" })
vim.keymap.set("n", "<leader>ce", ":Trouble lsp_references toggle<CR>", { desc = "Show references" })
vim.keymap.set("n", "<leader>ci", ":Trouble lsp_implementations toggle<CR>", { desc = "Show implementations" })

require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", ":IncRename ", { desc = "Rename selected" })

require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	highlight_on_hover = true,
})
vim.keymap.set("n", "<leader>co", ":AerialToggle<CR>", { desc = "Show outline" })

require("actions-preview").setup({
	highlight_command = {
		require("actions-preview.highlight").delta(),
	},
	backend = { "telescope" },
})
vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, { desc = "Show code actions" })

require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	sign = {
		text = "󰋇",
		lens_text = "󱤀",
	},
})
