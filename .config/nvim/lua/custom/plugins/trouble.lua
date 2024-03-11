return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    vim.keymap.set("n", "<leader>wd", function() require("trouble").toggle("workspace_diagnostics") end,
      { desc = "Trouble: [W]orkspace [D]iagnostics" }),
    vim.keymap.set("n", "<leader>dd", function() require("trouble").toggle("document_diagnostics") end,
      { desc = "Trouble: [D]ocument [D]iagnostics" }),
    vim.keymap.set("n", "<leader>ct", function() require("trouble").toggle("quickfix") end,
      { desc = "Trouble: [C]ode actions [T]rouble" }),
  },
}
