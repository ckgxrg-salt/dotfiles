require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { timeout_ms = 2000 },
  formatters = {
    -- Force 2 spaces with stylua
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
  formatters_by_ft = {
    _ = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
    rust = { "rustfmt" },
    nix = { "nixfmt" },
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
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  java = { "checkstyle" },
  rust = { "clippy" },
  nix = { "deadnix" },
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

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
