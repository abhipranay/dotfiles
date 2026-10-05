return {
  "abhipranay/nvim-go-sigrefactor",
  ft = "go",
  config = function()
    require("go-sigrefactor").setup({
      -- Optional: override binary path (auto-detected by default)
      -- binary = "/path/to/gosigrefactor",

      -- Keymaps
      keymaps = {
        change_signature = "<leader>cs", -- or set to false to disable
      },

      -- UI options
      ui = {
        border = "rounded",
        width = 60,
        height = 20,
      },
    })
  end,
}
