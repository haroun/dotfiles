-- source: "natecraddock/workspaces.nvim"
vim.pack.add({
  { src = "https://github.com/natecraddock/workspaces.nvim" },
})

require("workspaces").setup({
  hooks = {
    open = { "Telescope find_files" },
  },
})

vim.keymap.set("n", "<leader>wa", ":WorkspacesAdd<cr>", { desc = "Adds Workspace" })
vim.keymap.set("n", "<leader>wr", ":WorkspacesRemove<cr>", { desc = "Remove Workspace" })
vim.keymap.set("n", "<leader>wl", ":WorkspacesList<cr>", { desc = "List Workspace" })
vim.keymap.set("n", "<leader>wf", ":Telescope workspaces<cr>", { desc = "Find Workspace" })
vim.keymap.set("n", "<leader>ws", ":Telescope workspacesSyncDirs<cr>", { desc = "Find Workspace" })
