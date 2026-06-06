return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nordtheme/vim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("nord")
    -- end,
  },
}
