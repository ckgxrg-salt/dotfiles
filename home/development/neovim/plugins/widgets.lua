require("trouble").setup({
	open_no_results = true,
	warn_no_results = false,
})
vim.keymap.set("n", "<leader>cd", ":Trouble diagnostics toggle<CR>", { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>cq", ":Trouble quickfix toggle<CR>", { desc = "Show quickfix" })
vim.keymap.set("n", "<leader>cf", ":Trouble lsp_definitions toggle<CR>", { desc = "Show definitions" })
vim.keymap.set("n", "<leader>ce", ":Trouble lsp_references toggle<CR>", { desc = "Show references" })

require("codecompanion").setup({
	adapters = {
		http = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "cmd:cat $XDG_CONFIG_HOME/sops-nix/secrets/gemini-token",
					},
				})
			end,
		},
	},
	strategies = {
		chat = { adapter = "gemini" },
	},
})
vim.keymap.set("n", "<leader>ea", ":CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion" })

require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", ":IncRename ", { desc = "Rename selected" })

require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	highlight_on_hover = true,
})
vim.keymap.set("n", "<leader>eo", ":AerialToggle<CR>", { desc = "Display outline" })

-- undotree does not need setup
vim.keymap.set("n", "<leader>eu", ":UndotreeToggle<CR>", { desc = "Undo tree" })

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
