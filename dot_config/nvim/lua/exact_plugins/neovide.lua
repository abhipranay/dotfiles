-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_window_blurred = true

  -- scale neovide window
  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { noremap = true, silent = true })
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { noremap = true, silent = true })
  vim.keymap.set({ "n" , "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { noremap = true, silent = true })


  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  -- only set if NEOVIDE_CWD is set
  if vim.fn.getenv("NEOVIDE_CWD") then
    vim.api.nvim_set_current_dir(vim.fn.getenv("NEOVIDE_CWD"))
  end
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

return {}
