return {
  "fang2hou/go-impl.nvim",
  ft = "go",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",

    -- go-impl prefers snacks picker when available; fzf-lua not needed
    "folke/snacks.nvim",
  },
  opts = {},
  keys = {
    {
      "<leader>Gi",
      function()
        require("go-impl").open()
      end,
      mode = { "n" },
      desc = "Go Impl",
    },
  },
}
