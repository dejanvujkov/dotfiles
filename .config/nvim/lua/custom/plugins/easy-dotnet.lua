return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local dotnet = require 'easy-dotnet'
    dotnet.setup {
      lsp = {
        enabled = true,
        roslynator_enabled = true,
        analyzer_assemblies = {},
        config = {},
      },
      debugger = {
        -- adjust path to netcoredbg executable
        bin_path = '/Users/dejanvujkov/Downloads/netcoredbg/netcoredbg',
        auto_register_dap = true,
        mappings = {
          open_variable_viewer = { lhs = 'T', desc = 'open variable viewer' },
        },
      },
      test_runner = {
        viewmode = 'float',
        vsplit_width = nil,
        vsplit_pos = nil,
        enable_buffer_test_execution = true,
        noBuild = true,
        icons = {
          passed = '',
          skipped = '',
          failed = '',
          success = '',
          reload = '',
          test = '',
          sln = '󰘐',
          project = '󰘐',
          dir = '',
          package = '',
        },
        mappings = {
          -- These work IN test runner window AND from buffer (with gutter signs)
          run_test_from_buffer = { lhs = '<leader>dr', desc = 'run test from buffer' },
          peek_stack_trace_from_buffer = { lhs = '<leader>dp', desc = 'peek stack trace from buffer' },
          filter_failed_tests = { lhs = '<leader>fe', desc = 'filter failed tests' },
          debug_test = { lhs = '<leader>dd', desc = 'debug test' },
          go_to_file = { lhs = 'g', desc = 'go to file' },
          run_all = { lhs = '<leader>dR', desc = 'run all tests' },
          run = { lhs = '<leader>dr', desc = 'run test' },
          peek_stacktrace = { lhs = '<leader>dp', desc = 'peek stacktrace of failed test' },
          expand = { lhs = 'o', desc = 'expand' },
          expand_node = { lhs = 'E', desc = 'expand node' },
          expand_all = { lhs = '-', desc = 'expand all' },
          collapse_all = { lhs = 'W', desc = 'collapse all' },
          close = { lhs = 'q', desc = 'close testrunner' },
          refresh_testrunner = { lhs = '<C-r>', desc = 'refresh testrunner' },
        },
        additional_args = {},
      },
      new = {
        project = {
          prefix = 'sln',
        },
      },
      terminal = function(path, action, args)
        args = args or ''
        local commands = {
          run = function()
            return string.format('dotnet run --project %s %s', path, args)
          end,
          test = function()
            return string.format('dotnet test %s %s', path, args)
          end,
          restore = function()
            return string.format('dotnet restore %s %s', path, args)
          end,
          build = function()
            return string.format('dotnet build %s %s', path, args)
          end,
          watch = function()
            return string.format('dotnet watch --project %s %s', path, args)
          end,
        }
        local command = commands[action]()
        if require('easy-dotnet.extensions').isWindows() == true then
          command = command .. '\r'
        end
        vim.cmd 'vsplit'
        vim.cmd('term ' .. command)
      end,
      csproj_mappings = true,
      fsproj_mappings = true,
      auto_bootstrap_namespace = {
        type = 'block_scoped',
        enabled = true,
        use_clipboard_json = {
          behavior = 'prompt',
          register = '+',
        },
      },
      server = {
        log_level = nil,
      },
      picker = 'telescope',
      background_scanning = true,
      notifications = {
        handler = function(start_event)
          local spinner = require('easy-dotnet.ui-modules.spinner').new()
          spinner:start_spinner(start_event.job.name)
          return function(finished_event)
            spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
          end
        end,
      },
      diagnostics = {
        default_severity = 'error',
        setqflist = false,
      },
    }

    -- Commands
    vim.api.nvim_create_user_command('Secrets', function()
      dotnet.secrets()
    end, {})

    -- Global keybindings for easy-dotnet
    vim.keymap.set('n', '<leader>dp', function()
      dotnet.run_project()
    end, { desc = '[D]otnet run [p]roject' })

    vim.keymap.set('n', '<leader>dt', function()
      dotnet.testrunner()
    end, { desc = '[D]otnet open [t]est runner' })

    vim.keymap.set('n', '<leader>db', function()
      dotnet.build()
    end, { desc = '[D]otnet [b]uild' })

    vim.keymap.set('n', '<leader>ds', function()
      dotnet.secrets()
    end, { desc = '[D]otnet [s]ecrets' })

    vim.keymap.set('n', '<leader>dw', function()
      dotnet.watch()
    end, { desc = '[D]otnet [w]atch' })

    vim.keymap.set('n', '<leader>dc', function()
      dotnet.clean()
    end, { desc = '[D]otnet [c]lean' })
  end,
}

