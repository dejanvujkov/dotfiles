return {
  'numToStr/FTerm.nvim',
  config = function()
    require('FTerm').setup {
      size = 20,
      position = 'center',
      border = 'rounded',
    }
    vim.keymap.set({ 'n', 't' }, '<leader>tt', require('FTerm').toggle, { desc = '[T]oggle [t]erminal' })
  end,
}
