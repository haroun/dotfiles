return {
  {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["~"] = "<cmd>edit $HOME<CR>",
          ["gd"] = function()
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          end,
          ["`"] = "actions.tcd",
          ["<leader>:"] = {
            "actions.open_cmdline",
            opts = {
              shorten_path = true,
              modify = ":h",
            },
            desc = "Open the command line with the current directory as an argument",
          },
        },
      })

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

      -- Search file in current directory
      vim.keymap.set("n", "<leader>ff", function()
        require("telescope.builtin").find_files({ cwd = require("oil").get_current_dir() })
      end, { desc = "Find files in the current directory", nowait = true })
    end,
  },
}
