return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
      },
    },
  },

  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      extensions = {
        razor = {
          enabled = true,
          config = function()
            local razor_path = require("roslyn.utils").find_razor_extension_path()
            if razor_path == nil then
              return { path = nil }
            end
            return {
              path = vim.fs.joinpath(razor_path, "Microsoft.VisualStudioCode.RazorExtension.dll"),
            }
          end,
        },
      },
    },
  },
}