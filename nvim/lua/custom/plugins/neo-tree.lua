return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>te", ":Neotree toggle left<CR>", { desc = "[T]oggle [e]xplorer" })
    vim.keymap.set("n", "<leader>tb", ":Neotree buffers reveal float<CR>", { desc = "[T]oggle [b]uffers" })
  end,
}
