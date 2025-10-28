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
		local cwd = vim.fn.getcwd()
		local projects = require("project").get_recent_projects()
		if vim.fn.index(projects, cwd) ~= -1 then
			resession.save(cwd, { notify = true })
			resession.save("Last Session")
		end
	end,
})
vim.api.nvim_create_autocmd("StdinReadPre", {
	callback = function()
		vim.g.using_stdin = true
	end,
})
vim.keymap.set("n", "<leader>ts", ":Telescope resession<CR>", { desc = "Sessions" })

require("pick-resession").setup()
