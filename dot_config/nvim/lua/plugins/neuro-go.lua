return {
  {
    -- If you put the plugin folder inside your nvim/lua folder, you can load it directly.
    -- If it is an external folder, use: dir = "~/path/to/neuro-go.nvim"
    dir = "~/Documents/work/hellofresh/vimplugins/neuro-go.nvim", -- Update this to wherever you saved the plugin
    name = "neuro-go",
    lazy = false, -- We want the colorscheme to load immediately
    priority = 1000, -- Load before other plugins to prevent visual flashing
    config = function()
      -- Tell LazyVim to use your new theme
      vim.cmd("colorscheme neurogo")
    end,
  },
}
