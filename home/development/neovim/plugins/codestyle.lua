require("conform").setup({
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 2000 },
	formatters_by_ft = {
		_ = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },
		cpp = { "clang-format" },
		java = { "google-java-format" },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		haskell = { "ormolu" },
		sql = { "sqruff" },
		tex = { "latexindent" },
		typst = { "typstyle" },
		lua = { "stylua" },
		css = { "prettier" },
		scss = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		python = { "ruff_format" },
	},
	notify_no_formatters = true,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("lint").linters_by_ft = {
	cpp = { "clangtidy" },
	java = { "checkstyle" },
	rust = { "clippy" },
	nix = { "deadnix" },
	haskell = { "hlint" },
	sql = { "sqruff" },
	tex = { "lacheck" },
	css = { "eslint" },
	scss = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	python = { "ruff" },
}
require("lint").linters.checkstyle.config_file = "/google_checks.xml"
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

require("nvim-treesitter").setup({
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
