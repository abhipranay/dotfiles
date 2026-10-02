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
            "<cmd>lua require('telescope.builtin').lsp_implementations({ reuse_win = true })<CR>",
            "Goto Implementation",
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            buildFlags = { "-tags=integration testing unit feature" },
            analyses = {
              ST1000 = false, -- disable package comment check
            },
          },
        },
      },
    },
  },
}
