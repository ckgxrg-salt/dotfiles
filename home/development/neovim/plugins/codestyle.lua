require("conform").setup({
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 2000 },
	formatters_by_ft = {
		_ = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },
		cpp = { "clang-format" },
		css = { "prettier" },
		haskell = { "ormolu" },
		java = { "google-java-format" },
		lua = {"stylua"},
		nix = { "nixfmt" },
		rust = { "rustfmt" },
		scss = { "prettier" },
		tex = { "tex-fmt" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
	notify_no_formatters = true,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("lint").linters_by_ft = {
	cpp = { "clangtidy" },
	css = { "eslint" },
	haskell = { "hlint" },
	java = { "checkstyle" },
	lua = {"luacheck"},
	nix = { "deadnix" },
	rust = { "clippy" },
	scss = { "eslint" },
	tex = { "lacheck" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
}
require("lint").linters.checkstyle.config_file = "/google_checks.xml"
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function() require("lint").try_lint() end,
})

require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},
	indent = { enable = true },
	parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = "nil",
	},
})
