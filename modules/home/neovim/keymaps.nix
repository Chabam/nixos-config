{ ... }:
# Lua
''
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open [Q]uickfix list" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Open [Q]uickfix list" })

-- esc to exit insert mode
vim.keymap.set('t', '<esc><esc>', "<C-\\><C-n>")

vim.keymap.set("n", '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({"v", "x"}, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<leader>yy', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({'n', 'v', 'x'}, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })

vim.keymap.set('n', '<leader>tv', function()
  local config = vim.diagnostic.config()
  local new_config_vl = not config.virtual_lines
  local new_config_vt = not new_config_vl
  vim.diagnostic.config({ virtual_lines = new_config_vl, virtual_text = new_config_vt })
end, { desc = '[T]oggle diagnostic [v]irtual lines' })
''
