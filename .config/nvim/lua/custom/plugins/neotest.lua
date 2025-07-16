return {
  {
    'nvim-neotest/neotest',
    dependencies = { 'nvim-neotest/nvim-nio', 'Issafalcon/neotest-dotnet' },
    opts = {
      adapters = {
        ['neotest-dotnet'] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == 'number' then
            if type(config) == 'string' then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == 'table' and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                error('Adapter ' .. name .. ' does not support setup')
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require('neotest').setup(opts)
    end,
  -- stylua: ignore
  keys = {
    {"<leader>e", "", desc = "T[e]st"},
    { "<leader>et", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>eT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>er", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>el", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>es", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>eo", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>eO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>eS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>ew", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
  },
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
    optional = true,
  -- stylua: ignore
  keys = {
    { "<leader>ed", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
  },
  },
}
