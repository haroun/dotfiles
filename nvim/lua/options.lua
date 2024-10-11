-- global editor variables
-- NOTE: see `:help vim.g`
vim.g.mapleader = " " -- used for mappings as <leader>
vim.g.maplocalleader = " " -- used for mappings as <localleader> which are local to a buffer
-- vim.g.have_nerd_font = true

-- options
-- NOTE: see `:help vim.opt`
vim.opt.number = true -- print line number
vim.opt.relativenumber = true -- print relative line number
vim.opt.termguicolors = true -- enable 24-bit rgb color
vim.opt.expandtab = true -- use spaces for to insert a <tab>
vim.opt.tabstop = 2 -- number of spaces that a <tab> in the file counts for
vim.opt.softtabstop = 2 -- number of spaces that a <tab> counts for while performing editing operations, like inserting a <tab> or using <bs>
vim.opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.opt.autoindent = true -- copy indent from current line when starting a new line

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.wo.foldmethod = "expr" -- 'foldexpr' gives the fold level of a line
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- evaluated for each line to obtain its fold level
vim.wo.foldenable = false -- all folds are open

-- NOTE: see `:help modeline`
-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
