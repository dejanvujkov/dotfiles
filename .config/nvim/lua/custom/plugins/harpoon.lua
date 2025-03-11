return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    vim.keymap.set('n', '<leader>da', function()
      harpoon:list():append()
    end, { desc = 'Harpoon: [D]ocument [A]dd to Harpoon' })
    vim.keymap.set('n', '<leader>dr', function()
      harpoon:list():remove()
    end, { desc = 'Harpoon: [D]ocument [R]emove' })

    vim.keymap.set('n', '<leader>dt', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: [T]oogle Harpoon' })

    vim.keymap.set('n', '<leader>d1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: [D]ocument select [1]' })
    vim.keymap.set('n', '<leader>d2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: [D]ocument select [2]' })
    vim.keymap.set('n', '<leader>d3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: [D]ocument select [3]' })
    vim.keymap.set('n', '<leader>d4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: [D]ocument select [4]' })
  end,
}
