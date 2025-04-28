return {
  {
    "natecraddock/workspaces.nvim",
    keys = {
      { "<leader>wa", ":WorkspacesAdd<cr>", desc = "Adds Workspace" },
      { "<leader>wr", ":WorkspacesRemove<cr>", desc = "Remove Workspace" },
      { "<leader>wl", ":WorkspacesList<cr>", desc = "List Workspace" },
      { "<leader>wf", ":Telescope workspaces<cr>", desc = "Find Workspace" },
      { "<leader>ws", ":Telescope workspacesSyncDirs<cr>", desc = "Find Workspace" },
    },
    config = function()
      require("workspaces").setup({
        hooks = {
          open = { "Telescope find_files" },
        },
      })
    end,
  },
}
