return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- Document existing key chains
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      -- { "<leader>d", group = "[D]ocument" },
      -- { "<leader>r", group = "[R]ename" },
      { "<leader>f", group = "[F]ile" },
      { "<leader>s", group = "[S]earch" },
      -- { "<leader>w", group = "[W]orkspace" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>x", group = "[X] Diagnostics" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
