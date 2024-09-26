return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = "x",
              staged = "v",
              unmerged = "",
              renamed = ">",
              untracked = ".",
              deleted = "-",
              ignored = "◌",
            }
          }
        }
      },

      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- add your mappings
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      end,
    })

    vim.keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Reveal file" })
  end,
}
