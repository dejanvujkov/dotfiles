return {
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('spectre').setup()
      vim.keymap.set('n', '<leader>sR', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = '[S]earch & [R]eplace',
      })
    end,
  },
}
