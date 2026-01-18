vim.keymap.set("n", "<leader>ci", require("jdtls").organize_imports, { desc = "Java: Organise imports", buffer = true })
vim.keymap.set("n", "<leader>cv", require("jdtls").extract_variable, { desc = "Java: Extract variable", buffer = true })
vim.keymap.set("n", "<leader>cc", require("jdtls").extract_constant, { desc = "Java: Extract constant", buffer = true })
