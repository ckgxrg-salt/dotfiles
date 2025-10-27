require("project").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = {
		".git",
		".direnv",
		".marksman.toml",
		"flake.nix",
	},
	telescope = {
		enabled = true,
	},
})
require("telescope").load_extension("projects")

-- direnv.vim does not need setup
vim.g.direnv_silent_load = 1

local resession = require("resession")
resession.setup({
	autosave = {
		enabled = true,
		interval = 60,
		notify = false,
	},
	extensions = {
		barbar = {},
	},
})
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
			resession.load(vim.fn.getcwd(), { silence_errors = true })
		end
	end,
	nested = true,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save("Last Session")
		resession.save(vim.fn.getcwd(), { notify = true })
	end,
})
vim.api.nvim_create_autocmd("StdinReadPre", {
	callback = function()
		vim.g.using_stdin = true
	end,
})
vim.keymap.set("n", "<leader>ts", ":Telescope resession<CR>", { desc = "Sessions" })

require("pick-resession").setup()
