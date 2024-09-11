-- global editor variables
-- NOTE: see `:help vim.g`
vim.g.mapleader = " " -- used for mappings as <leader>
vim.g.maplocalleader = " " -- used for mappings as <localleader> which are local to a buffer
vim.g.have_nerd_font = true

-- options
-- NOTE: see `:help vim.opt`
vim.opt.number = true -- print line number
vim.opt.relativenumber = true -- print relative line number
vim.opt.termguicolors = true -- enable 24-bit rgb color

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- NOTE: see `:help modeline`
-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
