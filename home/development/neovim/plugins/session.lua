require("project").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = {
		".git",
		".direnv",
		"flake.nix",
	},
	telescope = {
		enabled = true,
	},
})
require("telescope").load_extension("projects")

-- direnv.vim does not need setup
vim.g.direnv_silent_load = 1

require("possession").setup({
	autosave = {
		current = true,
		cwd = function()
			return not require("possession.session").exists(require("possession.paths").cwd_session_name())
		end,
		on_load = true,
		on_quit = true,
	},
	autoload = "last_cwd",
	plugins = {
		nvim_tree = false,
		neo_tree = false,
		tabby = false,
		kulala = false,
	},
})
require("telescope").load_extension("possession")
