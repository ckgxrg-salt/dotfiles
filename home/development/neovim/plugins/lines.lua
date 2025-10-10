require("bufferline").setup({
	options = {
		close_command = function()
			MiniBufremove.delete()
		end,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
		numbers = "ordinal",
		right_mouse_command = function()
			MiniBufremove.delete()
		end,
		separator_style = "thin",
	},
})

require("lualine").setup({
	options = {
		disabled_filetypes = { winbar = { "dap-repl", "dap-view", "dap-view-term" } },
		globalstatus = true,
		theme = "base16",
	},
})

require("illuminate").configure({
	providers = { "lsp", "treesitter", "regex" },
	under_cursor = true,
})

vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-S-h>", ":BufferLineMovePrev<CR>", { desc = "Move buffer <-" })
vim.keymap.set("n", "<C-S-l>", ":BufferLineMoveNext<CR>", { desc = "Move buffer ->" })

vim.keymap.set("n", "<C-1>", ":BufferLineMovePrev 1<CR>")
vim.keymap.set("n", "<C-2>", ":BufferLineMovePrev 2<CR>")
vim.keymap.set("n", "<C-3>", ":BufferLineMovePrev 3<CR>")
vim.keymap.set("n", "<C-4>", ":BufferLineMovePrev 4<CR>")
vim.keymap.set("n", "<C-5>", ":BufferLineMovePrev 5<CR>")
