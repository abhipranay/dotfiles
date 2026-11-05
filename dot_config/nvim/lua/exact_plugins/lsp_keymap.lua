-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    autoformat = true,
    -- codelens is enabled natively in config/autocmds.lua; LazyVim's version adds a
    -- per-buffer CursorHold autocmd calling the deprecated vim.lsp.codelens.refresh
    codelens = {
      enabled = false,
    },
    servers = {
      golangci_lint_ls = {
        enabled = false,
      },
      ["*"] = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        keys = {
          {
            "gi",
            function() Snacks.picker.lsp_implementations() end,
            "Goto Implementation",
          },
        },
      },
      -- gopls settings live in config/autocmds.lua (manual vim.lsp.start wins the attach
      -- race, so a `gopls` block here is dead code and was removed).
    },
  },
}
