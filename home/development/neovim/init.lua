-- Options
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
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
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
require("plugins.debug")
require("plugins.langs")
require("plugins.utilities")
require("plugins.codestyle")
require("plugins.completions")
require("plugins.interface")
require("plugins.widgets")
require("plugins.decorations")
require("plugins.misc")
require("plugins.session")
require("plugins.test")
require("plugins.support")
