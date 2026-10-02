-- golangci-lint used to run twice for Go: nvim-lint (LazyVim go extra) and golangci_lint_ls
-- (auto-enabled by mason-lspconfig). The two runs collided on golangci's run lock (nvim-lint
-- failed with exit code 3), and golangci_lint_ls drops every issue when the resolved config
-- lives outside the module root (e.g. .github/linters/.golangci.yml), because golangci v2
-- reports paths relative to the config dir. Keep nvim-lint (uses --path-mode=abs) only.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      golangci_lint_ls = { enabled = false },
    },
  },
}
