-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- golang autocmds
-- run gci on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.go",
  callback = function(event)
    -- Use event.file if available, otherwise fallback to expand
    local relative_path = event.file or vim.fn.expand("%")
    local absolute_path = vim.fn.fnamemodify(relative_path, ":p")
    absolute_path = vim.fn.shellescape(absolute_path)

    local gci = string.format(
      'gci write %s -s standard -s default -s "prefix(github.com/hellofresh)" -s "prefix(github.com/hellofresh/reward-wallet)" --custom-order',
      absolute_path
    )

    vim.cmd("silent !" .. gci)
  end,
})
-- end golang autocmds
