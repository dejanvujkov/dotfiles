return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local Worktree = require 'git-worktree'
    local harpoon = require 'harpoon'

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        harpoon:list():clear()
        print('Switched to ' .. metadata.path)
      end
    end)

    vim.keymap.set('n', '<leader>gws', function()
      require('telescope').extensions.git_worktree.git_worktrees()
    end, { desc = '[G]it [W]orktree [S]witch' })

    vim.keymap.set('n', '<leader>gwc', function()
      require('telescope').extensions.git_worktree.create_git_worktree()
    end, { desc = '[G]it [W]orktree [C]reate' })

    vim.keymap.set('n', '<leader>gwd', function()
      require('telescope').extensions.git_worktree.git_worktrees()
    end, { desc = '[G]it [W]orktree [D]elete' })
  end,
}
