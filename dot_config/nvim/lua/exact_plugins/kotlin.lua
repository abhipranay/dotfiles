-- Kotlin LSP configuration using JetBrains official kotlin-lsp (Homebrew cask, same as Helix).
-- Uses nvim-lspconfig's built-in `kotlin_lsp` config via LazyVim's opts.servers.
-- After `brew upgrade kotlin-lsp`, re-run:
--   xattr -dr com.apple.quarantine /opt/homebrew/Caskroom/kotlin-lsp
local HOME = vim.env.HOME

return {
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "kotlin" },
    },
  },

  -- Disable treesitter-context for kotlin (broken grammar in nvim-treesitter)
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function(_, opts)
      opts.disable = opts.disable or {}
      table.insert(opts.disable, "kotlin")
      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Community server bundles Kotlin 2.1 compiler; can't read Kotlin 2.3+ library metadata
        kotlin_language_server = { enabled = false },
        kotlin_lsp = {
          mason = false, -- use the kotlin-lsp on PATH (Homebrew on macOS), not Mason
          cmd = {
            vim.fn.exepath("kotlin-lsp") ~= "" and vim.fn.exepath("kotlin-lsp") or "kotlin-lsp",
            "--stdio",
            "--system-path", -- keep index separate from Helix's
            HOME .. "/.cache/jetbrains-kotlin-lsp",
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
              if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(diagnostic)
                  local msg = diagnostic.message or ""
                  return not (msg:match("INCOMPATIBLE_CLASS") or msg:match("JAVA_MODULE_DOES_NOT_EXPORT_PACKAGE"))
                end, result.diagnostics)
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
          },
        },
      },
    },
  },
}
