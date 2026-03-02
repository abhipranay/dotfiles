return {
  {
    "folke/snacks.nvim",
    version = "v2.30.0",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,  -- show hidden files
            ignored = true, -- show gitignored files
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
            filter = { go = true },
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
            filter = { go = true },
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
