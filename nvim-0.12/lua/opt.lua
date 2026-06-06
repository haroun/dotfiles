require("vim._core.ui2").enable()

-- global options
-- NOTE: see `:help vim.go`
vim.g.mapleader = " "      -- used for mappings as <leader>
vim.g.maplocalleader = " " -- used for mappings as <localleader> which are local to a buffer

-- options
-- NOTE: see `:help vim.opt`
vim.opt.autocomplete = true
vim.opt.number = true         -- print line number
vim.opt.relativenumber = true -- print relative line number
vim.opt.termguicolors = true  -- enable 24-bit rgb color
vim.opt.expandtab = true      -- use spaces for to insert a <tab>
vim.opt.tabstop = 2           -- number of spaces that a <tab> in the file counts for
vim.opt.softtabstop = 2       -- number of spaces that a <tab> counts for while performing editing operations, like inserting a <tab> or using <bs>
vim.opt.shiftwidth = 2        -- number of spaces to use for each step of (auto)indent
vim.opt.autoindent = true     -- copy indent from current line when starting a new line
vim.opt.smartindent = true    -- do smart autoindenting when starting a new line
vim.opt.cursorline = true     -- highlight the text line of the cursor
vim.opt.wrap = false          -- don't wrap lines
vim.opt.scrolloff = 10        -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8     -- minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set
vim.opt.foldlevelstart = 99   -- start folding will no folds closed
vim.opt.completeopt = "menu,menuone,noselect,nearest"
vim.opt.signcolumn = "yes"    -- always draw the signcolumn
vim.opt.winborder = "bold"

-- window-scoped options
-- NOTE: see `:help vim.wo`
vim.wo.foldmethod = "expr"   -- 'foldexpr' gives the fold level of a line
vim.wo.foldenable = false    -- all folds are open

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- NOTE: see `:help modeline`
-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
