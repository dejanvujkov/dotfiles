return {
  {
    'coder/claudecode.nvim',
    opts = {
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.4,
        provider = 'native',
      },
    },
    keys = {
      { '<leader>a', nil, desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        '<cmd>ClaudeCode<cr>',
        desc = 'Toggle Claude',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        '<cmd>ClaudeCodeFocus<cr>',
        desc = 'Focus Claude',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        '<cmd>ClaudeCode<cr>',
        desc = 'Close Claude',
        mode = { 'n', 'v' },
      },
      {
        '<Esc>',
        '<C-\\><C-n>',
        desc = 'Exit terminal insert mode',
        mode = { 't' },
      },
      {
        '<leader>ap',
        '<cmd>ClaudeCodeSelectModel<cr>',
        desc = 'Select Claude Model',
        mode = { 'n', 'v' },
      },
      {
        '<leader>as',
        '<cmd>ClaudeCodeSend<cr>',
        desc = 'Send selection to Claude',
        mode = { 'v' },
      },
      {
        '<leader>ab',
        '<cmd>ClaudeCodeAdd %<cr>',
        desc = 'Add current buffer to Claude',
        mode = { 'n' },
      },
      {
        '<leader>aA',
        '<cmd>ClaudeCodeDiffAccept<cr>',
        desc = 'Accept Claude diff',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aD',
        '<cmd>ClaudeCodeDiffDeny<cr>',
        desc = 'Deny Claude diff',
        mode = { 'n', 'v' },
      },
    },
  },
}
