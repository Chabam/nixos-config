{ pkgs, ... }:
# Lua
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

vim.opt.shell = "${pkgs.bash}/bin/bash"

-- Diagnostic stuff
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
})

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.api.nvim_set_hl(0, "Error", { cterm=undercurl })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { link="Error" })
''
