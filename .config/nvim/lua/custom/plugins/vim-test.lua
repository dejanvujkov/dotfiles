return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.keymap.set("n", "<leader>ctn", ":TestNearest<CR>", { desc = "[C]ode [T]est [N]earest" })
    vim.keymap.set("n", "<leader>ctf", ":TestFile<CR>", { desc = "[C]ode [T]est [F]ile" })
    vim.keymap.set("n", "<leader>cts", ":TestSuite<CR>", { desc = "[C]ode [T]est [S]uite" })
    vim.keymap.set("n", "<leader>ctv", ":TestVisit<CR>", { desc = "[C]ode [T]est [V]ist" })

    vim.cmd("let test#strategy = 'vimux'")
  end
}
