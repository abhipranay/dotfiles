return {
  "abhipranay/argus.nvim",
  ft = "go",
  dev = true,

  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = function()
    return {
      width = 40,
      position = "right",
      icons = "mini",
      auto_preview = true,
    }
  end,
  keys = {
    { "<leader>co", "<cmd>ArgusToggle<cr>", desc = "Toggle Code Outline" },
  },
}
