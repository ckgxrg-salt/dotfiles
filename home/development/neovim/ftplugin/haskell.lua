vim.keymap.set(
	"n",
	"<leader>re",
	require("haskell-tools").lsp.buf_eval_all,
	{ desc = "Haskell: Evaluate all snippets", buffer = true }
)
vim.keymap.set(
	"n",
	"<leader>cs",
	require("haskell-tools").hoogle.hoogle_signature,
	{ desc = "Haskell: Show signature using Hoogle", buffer = true }
)
