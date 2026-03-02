return {
  {
    "Bekaboo/deadcolumn.nvim",
    opts = {
      scope = "buffer",
      ---@type string[]|boolean|fun(mode: string): boolean
      modes = function(mode)
        return mode:find("^[niRss\x13]") ~= nil
      end,
    },
  },
  { "kosayoda/nvim-lightbulb" },
  { "leoluz/nvim-dap-go" },
  -- {
  --   "ldelossa/gh.nvim",
  --   dependencies = {
  --     {
  --       "ldelossa/litee.nvim",
  --       config = function()
  --         require("litee.lib").setup()
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("litee.gh").setup()
  --   end,
  -- },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup()
    end,
  },
  {
    "pwntester/octo.nvim",
    opts = {
      use_local_fs = true,
      use_signcolumn = true,
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
