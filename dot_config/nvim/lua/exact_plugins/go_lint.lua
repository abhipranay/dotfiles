-- golangci-lint used to run twice for Go: nvim-lint (LazyVim go extra) and golangci_lint_ls
-- (auto-enabled by mason-lspconfig). The two runs collided on golangci's run lock (nvim-lint
-- failed with exit code 3), and golangci_lint_ls drops every issue when the resolved config
-- lives outside the module root (e.g. .github/linters/.golangci.yml), because golangci v2
-- reports paths relative to the config dir. Keep nvim-lint (uses --path-mode=abs) only.
--
-- Mason's golangci-lint is built with the Go version Mason had at install time (v2.10.1 was
-- built with go1.26) and panics with "file requires newer Go version go1.27" on a go1.27
-- toolchain (exit code 2, no diagnostics). Mason's bin dir shadows ~/go/bin inside nvim, so
-- pin nvim-lint to the system binary and stop Mason from reinstalling its own.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = { enabled = false },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters.golangcilint = vim.tbl_deep_extend("force", opts.linters.golangcilint or {}, {
        cmd = function()
          return vim.fn.expand("~/go/bin/golangci-lint")
        end,
      })
      return opts
    end,
  },
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "golangci-lint"
      end, opts.ensure_installed or {})
      return opts
    end,
  },
}
