-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>te", ":Neotree toggle left reveal=true<CR>", { desc = "[T]oggle [e]xplorer" })
vim.keymap.set({ "n", "t" }, "<leader>T", require("FTerm").toggle, { desc = "[T]oggle [t]erminal" })

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

vim.cmd.colorscheme("tokyonight-moon")

vim.keymap.set("n", "<F1>", require("dapui").toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F9>", require("dap").step_out, { desc = "Step Out" })
vim.keymap.set("n", "<F8>", require("dap").repl.toggle, { desc = "Toggle REPL" })
