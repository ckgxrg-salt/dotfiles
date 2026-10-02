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

	-- Only save session if there's a project
	auto_create = function()
	  return require("project").get_project_root() != nil
	end,
})
