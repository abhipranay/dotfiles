-- NOTE: Add { import = "lazyvim.plugins.extras.lang.clangd" } to lazy.lua spec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          keys = {
            { "gs", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
            { "<leader>ci", "<cmd>ClangdSymbolInfo<cr>", desc = "Symbol Info" },
            { "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", desc = "Type Hierarchy" },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          command = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang-format",
        },
      },
    },
  },
}
