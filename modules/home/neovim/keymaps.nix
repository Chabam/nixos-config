{ ... }:
# Lua
''
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open [Q]uickfix list" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Open [Q]uickfix list" })

-- esc to exit insert mode
vim.keymap.set('t', '<esc><esc>', "<C-\\><C-n>")
''
