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
-- save last session
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save("_last")
	end,
})
-- save directory sessions
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
			resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
		end
	end,
	nested = true,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
	end,
})
vim.api.nvim_create_autocmd("StdinReadPre", {
	callback = function()
		vim.g.using_stdin = true
	end,
})
vim.keymap.set("n", "<leader>ts", ":Telescope possession list<CR>", { desc = "Sessions" })
