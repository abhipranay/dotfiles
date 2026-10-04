-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- golang autocmds
-- run gci on save (async, so saving never blocks the UI)
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.go",
  callback = function(event)
    local buf = event.buf
    -- Use event.file if available, otherwise fallback to expand
    local relative_path = event.file or vim.fn.expand("%")
    local absolute_path = vim.fn.fnamemodify(relative_path, ":p")
    local saved_tick = vim.b[buf].changedtick

    vim.system({
      "gci",
      "write",
      absolute_path,
      "-s",
      "standard",
      "-s",
      "default",
      "-s",
      "prefix(github.com/hellofresh)",
      "-s",
      "prefix(github.com/hellofresh/reward-wallet)",
      "--custom-order",
    }, { text = true }, vim.schedule_wrap(function(result)
      if result.code ~= 0 then
        vim.notify("gci failed: " .. (result.stderr or ""), vim.log.levels.WARN)
        return
      end
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      -- only reload if nothing was typed since the save, so edits are never clobbered
      if vim.b[buf].changedtick ~= saved_tick then
        vim.notify("gci: buffer changed during import sort, not reloaded", vim.log.levels.WARN)
        return
      end
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("checktime")
      end)
    end))
  end,
})

-- Manual gopls start as workaround for broken lspconfig auto-attach
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(event)
    local clients = vim.lsp.get_clients({ bufnr = event.buf, name = "gopls" })
    if #clients == 0 then
      vim.lsp.start({
        name = "gopls",
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/packages/gopls/gopls") },
        root_dir = vim.fs.root(event.buf, { "go.mod", "go.work", ".git" }) or vim.fn.getcwd(),
        settings = {
          gopls = {
            buildFlags = { "-tags=integration testing unit feature" },
            gofumpt = true,
            analyses = {
              ST1000 = false,
              nilness = true,
              unusedparams = true,
            },
          },
        },
      })
    end
  end,
})
-- end golang autocmds

-- codelens: Neovim 0.12's provider refreshes lenses itself (debounced on text changes),
-- so a single global enable replaces LazyVim's CursorHold refresh autocmd
if vim.fn.has("nvim-0.12") == 1 then
  vim.lsp.codelens.enable(true)
end
