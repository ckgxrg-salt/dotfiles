vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("clangd")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("sqruff")

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

vim.lsp.config["jdtls"] = {
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
}
vim.lsp.enable("jdtls")

vim.lsp.enable("marksman")
require("markview").setup({
	preview = {
		filetypes = { "markdown", "codecompanion" },
		ignore_buftypes = {},
	},
})
vim.keymap.set("n", "<leader>em", ":Markview toggle<CR>", { desc = "Toggle Markdown view" })

vim.lsp.enable("texlab")
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk_engines = {
	["_"] = "-xelatex",
	["pdfdvi"] = "-pdfdvi",
	["pdfps"] = "-pdfps",
	["pdflatex"] = "-pdf",
	["luatex"] = "-lualatex",
	["lualatex"] = "-lualatex",
	["xelatex"] = "-xelatex",
	["context (pdftex)"] = "-pdf -pdflatex=texexec",
	["context (luatex)"] = "-pdf -pdflatex=context",
	["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
}

vim.lsp.config["tinymist"] = {
	settings = {
		exportPdf = "onType",
		semanticTokens = "disable",
	},
}
vim.lsp.enable("tinymist")
vim.api.nvim_create_user_command("TinymistOpenPdf", function()
	local filepath = vim.api.nvim_buf_get_name(0)

	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf")

		vim.system({ "okular", pdf_path })
	end
end, {})
