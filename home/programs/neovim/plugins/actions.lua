require("trouble").setup({
	warn_no_results = true,
})
vim.keymap.set("n", "<leader>cd", ":Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>cf", ":Trouble lsp_definitions toggle<CR>", { desc = "Definitions" })
vim.keymap.set("n", "<leader>ce", ":Trouble lsp_references toggle<CR>", { desc = "References" })
vim.keymap.set("n", "<leader>ci", ":Trouble lsp_implementations toggle<CR>", { desc = "Implementations" })

require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", ":IncRename ", { desc = "Rename" })

require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	highlight_on_hover = true,
})
vim.keymap.set("n", "<leader>co", ":AerialToggle<CR>", { desc = "Outline" })

require("actions-preview").setup({
	highlight_command = {
		require("actions-preview.highlight").delta(),
	},
	backend = { "telescope" },
})
vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, { desc = "Code Actions" })

require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	sign = {
		text = "",
	},
})
