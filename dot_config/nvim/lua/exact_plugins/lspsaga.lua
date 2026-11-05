-- Small, standalone plugin specs. (Historically named lspsaga.lua; lspsaga itself is gone.)
return {
  {
    "Bekaboo/deadcolumn.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      scope = "buffer",
      ---@type string[]|boolean|fun(mode: string): boolean
      modes = function(mode)
        return mode:find("^[niRss\x13]") ~= nil
      end,
    },
  },
  { "leoluz/nvim-dap-go", lazy = true }, -- loaded as a dependency of nvim-dap / neotest

  -- Minimalism: drop LazyVim UI layers that Helix doesn't have.
  { "folke/noice.nvim", enabled = false }, -- native cmdline/messages; no float re-routing
  { "akinsho/bufferline.nvim", enabled = false }, -- use <leader>, buffer picker + H/L
}
