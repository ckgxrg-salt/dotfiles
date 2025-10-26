require("edgy").setup({
	close_when_all_hidden = false,
	keys = { q = false },
	options = {
		bottom = { size = 0.3 },
		right = { size = 0.3 },
	},
	bottom = {
		{ ft = "dap-view", title = "Debug" },
		{ ft = "trouble", title = "Trouble" },
	},
	left = {
		{ ft = "undotree", title = "Undo tree" },
		{ ft = "aerial", title = "Outline" },
		{ ft = "neotest-summary", title = "Tests summary" },
	},
	right = {
		{ ft = "codecompanion", title = "CodeCompanion" },
		{ ft = "help", title = "Help" },
	},
})

require("toggleterm").setup({
	direction = "horizontal",
	size = 20,
})
vim.keymap.set("n", "<Leader>et", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

require("yazi").setup({
	enable_mouse_support = true,
	open_for_directories = true,
	yazi_floating_window_border = "solid",
	yazi_floating_window_winblend = 25,
})
vim.keymap.set("n", "<A-Tab>", require("yazi").yazi, { desc = "Browse files" })

require("fidget").setup({
	notification = {
		window = { winblend = 0 },
		override_vim_notify = true,
	},
	progress = {
		display = {
			done_ttl = 5,
			render_limit = 10,
		},
	},
})

require("hlchunk").setup({
	chunk = {
		chars = {
			horizontal_line = "─",
			left_bottom = "└",
			left_top = "┌",
			right_arrow = "─",
			vertical_line = "│",
		},
		enable = true,
	},
	indent = { enable = true },
	line_num = { enable = true },
})

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
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-S-h>", ":BufferLineMovePrev<CR>", { desc = "Move buffer <-" })
vim.keymap.set("n", "<C-S-l>", ":BufferLineMoveNext<CR>", { desc = "Move buffer ->" })
vim.keymap.set("n", "<C-1>", ":BufferLineMovePrev 1<CR>")
vim.keymap.set("n", "<C-2>", ":BufferLineMovePrev 2<CR>")
vim.keymap.set("n", "<C-3>", ":BufferLineMovePrev 3<CR>")
vim.keymap.set("n", "<C-4>", ":BufferLineMovePrev 4<CR>")
vim.keymap.set("n", "<C-5>", ":BufferLineMovePrev 5<CR>")

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

require("alpha").setup({
	layout = {
		{ type = "padding", val = 10 },
		{
			opts = { hl = "Type", position = "center" },
			type = "text",
			val = {
				"  ___| | ____ ___  ___ __ __ _           ",
				" / __| |/ / _` \\ \\/ / '__/ _` |          ",
				"| (__|   < (_| |>  <| | | (_| |          ",
				" \\___|_|\\_\\__, /_/\\_\\_|  \\__, | 's Neovim",
				"          |___/          |___/           ",
			},
		},
		{ type = "padding", val = 4 },
		{
			opts = { inherit = { position = "center" } },
			type = "group",
			val = {
				{
					on_press = function()
						vim.cmd("ene")
					end,
					opts = { shortcut = "n" },
					type = "button",
					val = "     New file  ",
				},
				{
					on_press = function()
						vim.cmd("Telescope projects")
					end,
					opts = { shortcut = "p" },
					type = "button",
					val = "     Projects  ",
				},
				{
					on_press = function()
						vim.cmd("Telescope possession list")
					end,
					opts = { shortcut = "s" },
					type = "button",
					val = "     Sessions  ",
				},
				{
					on_press = function()
						vim.cmd("PossessionLoad")
					end,
					opts = { shortcut = "l" },
					type = "button",
					val = " 󱑀  Last session",
				},
				{
					on_press = function()
						vim.cmd("qa")
					end,
					opts = { shortcut = "q" },
					type = "button",
					val = " 󰜎    Run away  ",
				},
			},
		},
		{ type = "padding", val = 4 },
		{
			opts = { hl = "Keyword", position = "center" },
			type = "text",
			val = function()
				return vim.fn.system("fortune")
			end,
		},
	},
})
