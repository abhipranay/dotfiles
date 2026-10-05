return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local colors = {
        bg = "#0D161D", -- Editor Background: A deep, rich, dark teal
        ui_bg = "#111C26", -- Tool Windows: Just slightly lighter for the explorer
        border = "#1E2C3A", -- Visible separators: Adjusted to match the blue/teal hue
        ui_bg_dim = "#080E13", -- Borders & Prompts: Very dark teal-black

        fg = "#CFD8DC",
        comment = "#5E8299",
        property = "#7ACEF5",
        error = "#FF6B68",
        warning = "#FFC66D",
      }

      -- 1. Restore clear tabs, remove the underline
      opts.options.separator_style = "thin" -- Uses clean vertical lines to separate tabs
      opts.options.indicator = {
        style = "none", -- Removes the distracting underline completely
      }
      opts.options.show_buffer_close_icons = true
      opts.options.show_close_icon = false

      -- 2. Inject the colors with visible separators
      opts.highlights = {
        fill = { bg = colors.ui_bg },
        background = { bg = colors.ui_bg, fg = colors.comment },
        buffer_selected = { bg = colors.bg, fg = colors.fg, bold = true },

        -- Make the borders between tabs actually visible!
        separator = { bg = colors.ui_bg, fg = colors.border },
        separator_selected = { bg = colors.bg, fg = colors.border },

        indicator_selected = { fg = colors.bg, bg = colors.bg }, -- Hidden
        modified = { bg = colors.ui_bg, fg = colors.property },
        modified_selected = { bg = colors.bg, fg = colors.property },
        close_button = { bg = colors.ui_bg, fg = colors.comment },
        close_button_selected = { bg = colors.bg, fg = colors.fg },
        error = { bg = colors.ui_bg, fg = colors.error },
        error_selected = { bg = colors.bg, fg = colors.error, bold = true },
        warning = { bg = colors.ui_bg, fg = colors.warning },
        warning_selected = { bg = colors.bg, fg = colors.warning, bold = true },
        duplicate_selected = { bg = colors.bg, fg = colors.fg, italic = true },
        duplicate = { bg = colors.ui_bg, fg = colors.comment, italic = true },
      }
    end,
  },
}
