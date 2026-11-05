-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- TypeScript LSP - use vtsls (required for LazyVim v8+)
vim.g.lazyvim_ts_lsp = "vtsls"

-- Set JAVA_HOME for Kotlin LSP (requires Java 17-21, not 26+); only where the Homebrew JDK exists
local brew_jdk21 = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
if vim.fn.isdirectory(brew_jdk21) == 1 then
  vim.env.JAVA_HOME = brew_jdk21
end

-- make sure mousemoveevent is enabled
vim.o.mousemoveevent = true

-- LazyVim picks the grep/find root from the first attached LSP before falling back to .git.
-- helm_ls roots at Chart.yaml (e.g. cmd/<svc>/helm), which makes <leader>/ search only that
-- chart dir — looks like "search only finds yaml files". Ignore it for root detection only.
vim.g.root_lsp_ignore = { "helm_ls" }
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldlevelstart = 1
vim.opt.foldtext = "" -- native 0.10+: keep syntax highlighting on folded line

-- Use tabs or spaces depending on the filetype
vim.cmd([[
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab colorcolumn=120
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType go setlocal colorcolumn=120
  autocmd Filetype c,cpp,rust,python,go,yaml,json setlocal foldmethod=expr
  autocmd Filetype c,cpp,rust,python,go,yaml,json setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
]])

vim.opt.pumblend = 0
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.o.mouse = vim.o.mouse .. "a"

-- folding: native treesitter folds, everything open by default
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- rounded borders for LSP hover/signature (previously via noice's lsp_doc_border preset)
vim.o.winborder = "rounded"

vim.o.updatetime = 200 -- Default is 4000ms, which is way too slow
