vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("texlab")
vim.lsp.enable("ts_ls")

vim.g.haskell_tools = {
	hls = {
		default_settings = {
			formattingProvider = "ormolu",
		},
	},
}

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				check = { command = "clippy" },
				inlayHints = {
					lifetimeElisionHints = { enable = "always" },
				},
			},
		},
		standalone = false,
	},
	tools = { enable_clippy = true },
}

vim.lsp.config("jdtls", {
	settings = {
		java = {
			codeGeneration = {
				generateComments = true,
				toString = {
					template = "${object.className}{${member.name()}=${member.value},${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	},
})
vim.lsp.enable("jdtls")

require("markview").setup({
	preview = {
		filetypes = { "markdown", "codecompanion" },
		ignore_buftypes = {},
	},
})

require("zk").setup({
	picker = "telescope",
	picker_options = {
		telescope = require("telescope.themes").get_dropdown(),
	},
})

vim.keymap.set("n", "<leader>em", ":Markview toggle<CR>", { desc = "Toggle Markdown view" })
