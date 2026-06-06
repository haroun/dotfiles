-- source: "folke/todo-comments.nvim"
vim.pack.add({
  { src = "https://github.com/folke/todo-comments.nvim" },
})

-- TODO: event = "VimEnter",
require("todo-comments").setup({
  signs = false,
})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

-- vim.keymap.set("n", "]t", function()
--   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })
