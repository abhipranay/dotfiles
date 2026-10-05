return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "leoluz/nvim-dap-go",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          go_test_args = { "-v", "-count=1", "-tags=unit,testing,integration" },
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          -- runner = "gotestsum",
          gotestsum_args = {
            "--format=standard-verbose",
            "--format-icons=hivis",
          },
          testify_enabled = true,
          running = {
            -- Run tests concurrently when an adapter provides multiple commands to run.
            concurrent = true,
          },
          summary = {
            -- Enable/disable animation of icons.
            animated = false,
          },
        },
      },
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 0,
      },
    },
  },
}
