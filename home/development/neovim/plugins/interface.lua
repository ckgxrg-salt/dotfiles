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
	},
	progress = {
		display = {
			done_ttl = 5,
			render_limit = 10,
		},
	},
})

require("edgy").setup({
	close_when_all_hidden = false,
	keys = { q = false },
	options = {
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
	right = { { ft = "codecompanion", title = "CodeCompanion" }, { ft = "help", title = "Help" } },
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

require("trouble").setup({
	open_no_results = true,
	warn_no_results = false,
})
vim.keymap.set("n", "<leader>cd", ":Trouble diagnostics toggle<CR>", { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>cq", ":Trouble quickfix toggle<CR>", { desc = "Show quickfix" })
vim.keymap.set("n", "<leader>cf", ":Trouble lsp_definitions toggle<CR>", { desc = "Show definitions" })
vim.keymap.set("n", "<leader>ce", ":Trouble lsp_references toggle<CR>", { desc = "Show references" })

require("codecompanion").setup({
	adapters = {
		http = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "cmd:cat $XDG_CONFIG_HOME/sops-nix/secrets/gemini-token",
					},
				})
			end,
		},
	},
	strategies = {
		chat = { adapter = "gemini" },
	},
})
vim.keymap.set("n", "<leader>ea", ":CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion" })

require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", ":IncRename ", { desc = "Rename selected" })

require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	highlight_on_hover = true,
})
vim.keymap.set("n", "<leader>eo", ":AerialToggle<CR>", { desc = "Display outline" })

vim.notify = require("notify")
require("notify").setup({
	background_colour = "#000000",
	timeout = 10000,
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
