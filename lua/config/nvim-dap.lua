local keymap = vim.keymap

require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb" },
    automatic_installation = true,
})

local dap = require("dap")

dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
}

local lldb = {
    name = "Launch cpp",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    MIMode = "codelldb",
};


dap.configurations = {
    cpp = { lldb },
    rust = { lldb },
    c = { lldb },
}

keymap.set("n", "<leader>dt", function()
    require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

keymap.set("n", "<leader>dc", function()
    require("dap").continue()
end, { desc = "Continue" })

keymap.set("n", "<leader>dj", function()
    require("dap").step_over()
end, { desc = "Step over" })

keymap.set("n", "<leader>dl", function()
    require("dap").step_into()
end, { desc = "Step into" })

keymap.set("n", "<leader>dh", function()
    require("dap").step_out()
end, { desc = "Step out"})

keymap.set("n", "<leader>dk", function()
    require("dap").restart_frame()
end, { desc = "Restart frame" })

keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
end, { desc = "Open REPL" })

keymap.set("n", "<leader>dq", function()
    require("dap").terminate()
    require("dapui").close()
    require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate" })

keymap.set("n", "<leader>db", function()
    require("dap").list_breakpoints()
end, { desc = "List Breakpoints" })

ui = require("dapui")

ui.setup()

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
