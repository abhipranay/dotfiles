-- golangci-lint used to run twice for Go: nvim-lint (LazyVim go extra) and golangci_lint_ls
-- (auto-enabled by mason-lspconfig). The two runs collided on golangci's run lock (nvim-lint
-- failed with exit code 3), and golangci_lint_ls drops every issue when the resolved config
-- lives outside the module root (e.g. .github/linters/.golangci.yml), because golangci v2
-- reports paths relative to the config dir. Keep nvim-lint (uses --path-mode=abs) only.
--
-- Mason's golangci-lint was built with an older Go and panics on newer toolchains, so pin the
-- system binary in ~/go/bin and stop Mason from reinstalling its own.
--
-- PERF: nvim-lint's bundled `lint.linters.golangcilint` module runs `golangci-lint version`
-- and `go env GOMOD` with blocking vim.fn.system at require time (~600ms UI freeze on the first
-- Go buffer). We register the linter as a *function* returning a static v2 spec, so LazyVim
-- never deep-merges into (and therefore never requires) the bundled module.
local severities = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  refactor = vim.diagnostic.severity.INFO,
  convention = vim.diagnostic.severity.HINT,
}

local spec = {
  name = "golangcilint",
  cmd = vim.fn.expand("~/go/bin/golangci-lint"),
  append_fname = false,
  stream = "stdout",
  args = {
    "run",
    "--output.json.path=stdout",
    -- Overwrite values possibly set in .golangci.yml
    "--output.text.path=",
    "--output.tab.path=",
    "--output.html.path=",
    "--output.checkstyle.path=",
    "--output.code-climate.path=",
    "--output.junit-xml.path=",
    "--output.teamcity.path=",
    "--output.sarif.path=",
    "--issues-exit-code=0",
    "--show-stats=false",
    "--path-mode=abs",
    function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
    end,
  },
  parser = function(output, bufnr, cwd)
    if output == "" then
      return {}
    end
    local ok, decoded = pcall(vim.json.decode, output)
    if not ok or type(decoded) ~= "table" or type(decoded.Issues) ~= "table" then
      return {}
    end
    -- realpath: on macOS /var -> /private/var, so compare resolved paths
    local function real(path)
      return vim.uv.fs_realpath(path) or vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
    end
    local curfile = real(vim.api.nvim_buf_get_name(bufnr))
    local diagnostics = {}
    for _, item in ipairs(decoded.Issues) do
      local filename = item.Pos.Filename
      if filename:sub(1, 1) ~= "/" then
        filename = cwd .. "/" .. filename
      end
      if curfile == real(filename) then
        local line = item.Pos.Line > 0 and item.Pos.Line - 1 or 0
        local col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0
        table.insert(diagnostics, {
          lnum = line,
          col = col,
          end_lnum = line,
          end_col = col,
          severity = severities[item.Severity] or severities.warning,
          source = item.FromLinter,
          message = item.Text,
        })
      end
    end
    return diagnostics
  end,
}

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
      opts.linters.golangcilint = function()
        return spec
      end
      -- Lint on open and save only: LazyVim's InsertLeave trigger re-runs a whole-package
      -- golangci-lint every time you leave insert mode.
      opts.events = { "BufReadPost", "BufWritePost" }
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
