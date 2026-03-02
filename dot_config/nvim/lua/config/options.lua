-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- make sure mousemoveevent is enabled
vim.o.mousemoveevent = true
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldlevelstart = 1
vim.opt.foldtext = "v:lua.nvim_treesitter_foldtext()"

-- Use tabs or spaces depending on the filetype
vim.cmd([[
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab colorcolumn=120
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType go setlocal colorcolumn=120
  autocmd Filetype c,cpp,rust,python,go,yaml,json setlocal foldmethod=expr
  autocmd Filetype c,cpp,rust,python,go,yaml,json setlocal foldexpr=nvim_treesitter#foldexpr()
]])

vim.opt.pumblend = 0
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.o.mouse = vim.o.mouse .. "a"

-- ufo start --
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- ufo end --

vim.o.updatetime = 200 -- Default is 4000ms, which is way too slow
