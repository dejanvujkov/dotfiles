return {
  {
    'folke/snacks.nvim',
    opts = {
      navigate = { enable = true },
      terminal = {
        keys = {
          nav_h = { '<C-h>', '<cmd>wincmd h<cr>', desc = 'Go to left window', mode = { 'n', 't' } },
        },
      },
    },
  },
}
