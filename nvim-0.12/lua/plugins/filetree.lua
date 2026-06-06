-- Using netrw
-- 1. Open netrw and focus current file
-- vim.keymap.set("n", "-", function()
--   vim.cmd("Explore %:p:h")
--   -- vim.cmd("Explore %:p:h")
--   -- vim.cmd("normal! gg")
--   -- vim.fn.search(vim.fn.expand("%:t"))
-- end, { desc = "Reveal current file" })

-- 2. Open netrw at parent directory
-- vim.keymap.set("n", "<leader>-", function()
--   vim.cmd("Explore %:p:h:h")
-- end, { desc = "Open parent directory" })

-- source: "stevearc/oil.nvim"
vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
})

-- TODO: keep keymaps?
-- TODO: keymaps options shorten_path working?
-- vim.keymap.set("n", "~", "<cmd>edit $HOME<CR>")
-- vim.keymap.set("n", "gd", function()
--   require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
-- end)
-- vim.keymap.set("n", "`", "actions.tcd")
-- vim.keymap.set("n", "<leader>:", "actions.open_cmdline", {
--   opts = {
--     shorten_path = true,
--     modify = ":h",
--   },
--   desc = "Open the command line with the current directory as an argument",
-- })

-- open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- open parent directory in floating window
vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

-- search file in current directory
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ cwd = require("oil").get_current_dir() })
end, { desc = "Find files in the current directory", nowait = true })
