return {
  'Exafunction/codeium.vim',
  config = function()
    vim.keymap.set("i", "<c-.>", function() return vim.fn["codeium#Accept"]() end,
      { expr = true, desc = "Codeium Accept" })
    vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end,
      { expr = true, desc = "Codeium Clear" })
  end
}
