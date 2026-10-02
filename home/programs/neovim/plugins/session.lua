require("project").setup({
	patterns = {
		".git",
		".direnv",
		".marksman.toml",
		"flake.nix",
	},
})
require("telescope").load_extension("projects")

require("auto-session").setup({
	lazy_support = false,
})
