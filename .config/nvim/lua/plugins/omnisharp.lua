return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      omnisharp = {
        -- Run OmniSharp.dll via the system dotnet runtime instead of the mason-installed
        -- self-contained net6 binary. The net6 binary cannot load EF Core 9.x analyzers,
        -- which causes all textDocument/codeAction requests to crash with FileNotFoundException.
        cmd = {
          "dotnet",
          vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"),
          "-z",
          "--hostPID",
          tostring(vim.fn.getpid()),
          "DotNet:enablePackageRestore=false",
          "--encoding",
          "utf-8",
          "--languageserver",
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        on_init = function(client)
          -- OmniSharp doesn't reliably advertise codeActionProvider, which causes
          -- LazyVim's `has = "codeAction"` guard to suppress the <leader>ca keymap.
          -- Force the capability so the keymap and vim.lsp.buf.code_action() work.
          client.server_capabilities.codeActionProvider = true
        end,
        settings = {
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
          },
        },
      },
    },
  },
}
