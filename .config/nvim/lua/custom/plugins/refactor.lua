return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()

    vim.keymap.set({ "n", "x" }, "<leader>rr", ":lua require('refactoring').select_refactor()<CR>",
      { noremap = true, silent = true, desc = "[R]efacto[r]" })
  end,
}
