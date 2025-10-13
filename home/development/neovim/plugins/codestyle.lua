require("conform").setup({
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 2000 },
	formatters_by_ft = {
		_ = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },
		cpp = { "clang-format" },
		java = { "google-java-format" },
		rust = { "rustfmt" },
		markdown = { "prettier" },
		nix = { "nixfmt" },
		haskell = { "ormolu" },
		tex = { "tex-fmt" },
		lua = { "stylua" },
		css = { "prettier" },
		scss = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
	notify_no_formatters = true,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("lint").linters_by_ft = {
	cpp = { "clangtidy" },
	java = { "checkstyle" },
	rust = { "clippy" },
	markdown = { "markdownlint" },
	nix = { "deadnix" },
	haskell = { "hlint" },
	tex = { "lacheck" },
	lua = { "luacheck" },
	css = { "eslint" },
	scss = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
}
require("lint").linters.checkstyle.config_file = "/google_checks.xml"
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
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
