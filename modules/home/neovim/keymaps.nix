{ ... }:
# Lua
''
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- esc to exit insert mode
vim.keymap.set('t', '<esc><esc>', "<C-\\><C-n>")
''
