require("dap").adapters = {
	lldb = {
		command = "/nix/store/kbc27w69l4gf8ajqk2n5gmvi9gl4c91i-lldb-19.1.7/bin/lldb-dap",
		type = "executable",
	},
}
require("dap").configurations = {
	rust = {
		{
			cwd = "${workspaceFolder}",
			name = "Launch an executable",
			program = function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				return coroutine.create(function(coro)
					local opts = {}
					pickers
						.new(opts, {
							prompt_title = "Path to executable",
							finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
							sorter = conf.generic_sorter(opts),
							attach_mappings = function(buffer_number)
								actions.select_default:replace(function()
									actions.close(buffer_number)
									coroutine.resume(coro, action_state.get_selected_entry()[1])
								end)
								return true
							end,
						})
						:find()
				end)
			end,
			request = "launch",
			type = "lldb",
		},
		{
			cwd = "${workspaceFolder}",
			name = "Select and attach to process",
			pid = function()
				local name = vim.fn.input("Executable name (filter): ")
				return require("dap.utils").pick_process({ filter = name })
			end,
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			request = "attach",
			type = "lldb",
		},
	},
}

require("dap-view").setup({
	winbar = {
		default_section = "breakpoints",
	},
})

require("nvim-dap-virtual-text").setup({
	commented = true,
})

vim.fn.sign_define("DapBreakpoint", { text = "󰺕 " })
vim.fn.sign_define("DapBreakpointCondition", { text = " " })
vim.fn.sign_define("DapBreakpointRejected", { text = " " })
vim.fn.sign_define("DapLogPoint", { text = "󰣕 " })
vim.fn.sign_define("DapStopped", { text = "󰆷 " })

vim.keymap.set("n", "<leader>du", ":DapViewToggle<CR>", { desc = "Toggle debug view" })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Add/Remove breakpoint" })
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { desc = "Start/Continue debugging" })
vim.keymap.set("n", "<leader>ds", ":DapStepOver<CR>", { desc = "Step over" })
vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", { desc = "Step into" })
vim.keymap.set("n", "<leader>do", ":DapStepOut<CR>", { desc = "Step out" })
