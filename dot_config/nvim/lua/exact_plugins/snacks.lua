return {
  {
    "folke/snacks.nvim",
    version = "v2.30.0",
    init = function()
      -- When the explorer is unfocused, snacks highlights the followed file with the global
      -- CursorLine group, which neurogo paints the same colour as the explorer background.
      -- Give the unfocused explorer its own group so the current file stays visible.
      local function set_hl()
        vim.api.nvim_set_hl(0, "SnacksPickerListCursorLineNC", { bg = "#2E4F66", fg = "#7ACEF5", bold = true })
      end
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          set_hl()
          local List = require("snacks.picker.core.list")
          if List._explorer_nc_patched then
            return
          end
          List._explorer_nc_patched = true
          local update_cursorline = List.update_cursorline
          function List:update_cursorline()
            update_cursorline(self)
            if self.picker.opts.source == "explorer" and not self.picker:is_focused() and self.win:win_valid() then
              Snacks.util.wo(self.win.win, {
                winhighlight = Snacks.util.winhl(vim.wo[self.win.win].winhighlight, {
                  CursorLine = "SnacksPickerListCursorLineNC",
                }),
              })
            end
          end
        end,
      })
    end,
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- show hidden files
            ignored = true, -- show gitignored files
            follow_file = true, -- follow the current file (`follow` would mean "follow symlinks")
            focus = "list", -- focus the list when opening
            layout = {
              preset = "sidebar",
              preview = "main",
              layout = { position = "left", width = 40 },
            },
          },
          files = {
            layout = {
              layout = {
                box = "horizontal",
                width = 0.9,
                height = 0.9,
                {
                  box = "vertical",
                  border = true,
                  title = "{title} {live} {flags}",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = true, width = 0.5 },
              },
            },
          },
          grep = {
            layout = {
              layout = {
                box = "horizontal",
                width = 0.9,
                height = 0.9,
                {
                  box = "vertical",
                  border = true,
                  title = "{title} {live} {flags}",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = true, width = 0.5 },
              },
            },
          },
          lsp_symbols = {
            layout = {
              layout = {
                box = "horizontal",
                width = 0.9,
                height = 0.9,
                {
                  box = "vertical",
                  border = true,
                  title = "{title} {live} {flags}",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = true, width = 0.5 },
              },
            },
          },
          lsp_workspace_symbols = {
            live = true,
            layout = {
              layout = {
                box = "horizontal",
                width = 0.9,
                height = 0.9,
                {
                  box = "vertical",
                  border = true,
                  title = "{title} {live} {flags}",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = true, width = 0.5 },
              },
            },
          },
          lsp_references = {
            layout = {
              layout = {
                box = "horizontal",
                width = 0.9,
                height = 0.9,
                {
                  box = "vertical",
                  border = true,
                  title = "{title} {live} {flags}",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                },
                { win = "preview", title = "{preview}", border = true, width = 0.5 },
              },
            },
          },
        },
      },
    },
  },
}
