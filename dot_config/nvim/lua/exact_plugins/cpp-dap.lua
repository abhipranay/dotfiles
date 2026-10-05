return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      dap.adapters.lldb = {
        type = "executable",
        command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap",
        name = "lldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch executable",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ", { trimempty = true })
          end,
        },
        {
          name = "Attach to process",
          type = "lldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
