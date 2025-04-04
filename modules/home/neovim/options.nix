{ ... }:
''
local tab_width = 4
vim.opt.tabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.softtabstop = tab_width
vim.opt.expandtab = true

vim.opt.list = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", space = "·", nbsp = "␣" }

vim.opt.inccommand = "split"
vim.opt.scrolloff = 2

vim.diagnostic.config({
  virtual_lines = {
    current_line = true
  },
  signs = true,
})
''
