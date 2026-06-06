vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.diagnostic.config({
  severity_sort = true,
  -- signs = {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = "E",
  --     [vim.diagnostic.severity.WARN] = "W",
  --     [vim.diagnostic.severity.INFO] = "I",
  --     [vim.diagnostic.severity.HINT] = "H",
  --   },
  -- },
})
