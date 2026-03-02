return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- The exact Abyss Black / Aurora Borealis palette
      local colors = {
        bg = "#0D161D", -- Editor Background: A deep, rich, dark teal
        ui_bg = "#111C26", -- Tool Windows: Just slightly lighter for the explorer
        border = "#1E2C3A", -- Visible separators: Adjusted to match the blue/teal hue
        ui_bg_dim = "#080E13", -- Borders & Prompts: Very dark teal-black

        fg = "#CFD8DC", -- Base text
        comment = "#5E8299", -- Muted text

        -- Aurora Accents for Vim Modes
        normal = "#549EFF", -- Bright Blue
        insert = "#73D379", -- Luminous Green
        visual = "#BAA5FF", -- Ethereal Purple
        replace = "#FF6B68", -- Soft Coral/Red
        command = "#05C0A6", -- Aurora Teal
      }

      -- Define the custom Lualine theme
      local neurogo_lualine = {
        normal = {
          a = { bg = colors.normal, fg = colors.bg, gui = "bold" },
          b = { bg = colors.ui_bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.comment }, -- Blends seamlessly into the editor
        },
        insert = {
          a = { bg = colors.insert, fg = colors.bg, gui = "bold" },
          b = { bg = colors.ui_bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.comment },
        },
        visual = {
          a = { bg = colors.visual, fg = colors.bg, gui = "bold" },
          b = { bg = colors.ui_bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.comment },
        },
        replace = {
          a = { bg = colors.replace, fg = colors.bg, gui = "bold" },
          b = { bg = colors.ui_bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.comment },
        },
        command = {
          a = { bg = colors.command, fg = colors.bg, gui = "bold" },
          b = { bg = colors.ui_bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.comment },
        },
        inactive = {
          a = { bg = colors.ui_bg, fg = colors.comment },
          b = { bg = colors.ui_bg, fg = colors.comment },
          c = { bg = colors.ui_bg, fg = colors.comment },
        },
      }

      -- Apply the theme
      opts.options.theme = neurogo_lualine

      -- Remove the chunky powerline arrows for a modern, flat IDE look
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
