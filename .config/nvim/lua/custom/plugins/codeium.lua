return {
  "Exafunction/codeium.vim",
  config = function()
    vim.keymap.set('i', '<leader>cj', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true, { desc = "[C]ode Next Suggestion" } })
    vim.keymap.set('i', '<leader>ck', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true, { desc = "[C]ode Previous Suggestion" } })
    vim.keymap.set('i', '<leader>cx', function() return vim.fn['codeium#Clear']() end,
      { expr = true, silent = true, { desc = "[C]ode Clear Suggestion" } })
  end
}
