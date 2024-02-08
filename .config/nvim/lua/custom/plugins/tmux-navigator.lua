return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,

    config = function()
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate left" })
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate right" })
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate down" })
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate up" })
    end
  }
}
