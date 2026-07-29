require("project").setup({
	-- detection_methods = { "pattern", "lsp" },
	detection_methods = { "pattern" },
	patterns = {
		".git",
		".direnv",
		".marksman.toml",
		"flake.nix",
	},
	-- telescope = {
	--  enabled = true,
	-- },
})
require("telescope").load_extension("projects")

-- direnv.vim does not need setup
vim.g.direnv_silent_load = 1

require("auto-session").setup({
	lazy_support = false,
})
