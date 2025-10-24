-- Options
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.expandtab = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.winborder = "single"
vim.opt.wrap = true

-- Globals
vim.g.mapleader = " "

-- Diagnostics
vim.diagnostic.config({
	signs = true,
	underline = true,
	update_in_insert = true,
	virtual_text = true,
	virtual_lines = { current_line = true },
})

-- Keybinds
vim.keymap.set("n", "<A-j>", "gj")
vim.keymap.set("n", "<A-k>", "gk")
vim.keymap.set("n", "<A-Down>", "gj")
vim.keymap.set("n", "<A-Up>", "gk")

-- Imports
require("plugins.langs")
require("plugins.codestyle")
require("plugins.completions")
require("plugins.debug")
require("plugins.interface")
require("plugins.decorations")
require("plugins.lines")
require("plugins.misc")
require("plugins.neotest")
require("plugins.which-key")
