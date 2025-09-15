local overseer = require("overseer")

overseer.setup({
    templates = { "builtin", "user.cpp_debug_build", "user.cpp_build", },
})

overseer.enable_dap()

local keymap = vim.keymap

keymap.set("n", "<leader>tr", "<cmd>OverseerRun<CR>", { desc = "Run task" })
keymap.set("n", "<leader>tl", "<cmd>OverseerToggle<CR>", { desc =  "Open task list" })
