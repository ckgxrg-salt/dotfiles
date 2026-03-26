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
vim.keymap.set("n", "<leader>ea", ":CodeCompanionChat Toggle<CR>", { desc = "Show CodeCompanion" })

-- undotree does not need setup
vim.keymap.set("n", "<leader>eu", ":UndotreeToggle<CR>", { desc = "Show undo tree" })

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
vim.keymap.set("v", "<leader>es", require("wtf").diagnose, { desc = "Diagnose code with AI" })
vim.keymap.set("v", "<leader>eS", require("wtf").search, { desc = "Diagnose code with search" })
