return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_windw = true,
    }

    vim.keymap.set('n', '<leader>te', ':Neotree toggle left reveal=true<CR>', { desc = '[T]oggle [e]xplorer' })
    vim.keymap.set('n', '<leader>to', ':Neotree toggle left reveal=true source=buffers <CR>', { desc = '[T]oggle [o]pened buffers' })
  end,
}
