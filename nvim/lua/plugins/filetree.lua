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
    --
    -- keys = {
    --   -- Mappings can be a string
    --   { "~", "<cmd>edit $HOME<CR>" },
    --   -- Mappings can be a function
    --   {
    --     "<leader>gd",
    --     function()
    --       require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
    --     end,
    --   },
    --   -- You can pass additional opts to vim.keymap.set by using
    --   -- a table with the mapping as the first element.
    --   {
    --     "<leader>ff",
    --     function()
    --       require("telescope.builtin").find_files({
    --         cwd = require("oil").get_current_dir(),
    --       })
    --     end,
    --     nowait = true,
    --     desc = "Find files in the current directory",
    --   },
    --   -- Mappings that are a string starting with "actions." will be
    --   -- one of the built-in actions, documented below.
    --   {
    --     "`",
    --     "actions.tcd",
    --   },
    --   -- Some actions have parameters. These are passed in via the `opts` key.
    --   {
    --     "<leader>:",
    --     "actions.open_cmdline",
    --     opts = {
    --       shorten_path = true,
    --       modify = ":h",
    --     },
    --     desc = "Open the command line with the current directory as an argument",
    --   },
    -- },
    -- config = function()
    --   vim.keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Reveal file" })
    -- end,
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup({
  --       renderer = {
  --         icons = {
  --           glyphs = {
  --             git = {
  --               unstaged = "x",
  --               staged = "v",
  --               unmerged = "",
  --               renamed = ">",
  --               untracked = ".",
  --               deleted = "-",
  --               ignored = "◌",
  --             },
  --           },
  --         },
  --       },
  --
  --       on_attach = function(bufnr)
  --         local api = require("nvim-tree.api")
  --         local function opts(desc)
  --           return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  --         end
  --
  --         -- default mappings
  --         api.config.mappings.default_on_attach(bufnr)
  --
  --         -- add your mappings
  --         vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  --       end,
  --     })
  --
  --     vim.keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Reveal file" })
  --   end,
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   version = "*",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = "Neotree",
  --   keys = {
  --     { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
  --   },
  --   opts = {
  --     filesystem = {
  --       window = {
  --         mappings = {
  --           ["\\"] = "close_window",
  --         },
  --       },
  --     },
  --   },
  -- },
}
