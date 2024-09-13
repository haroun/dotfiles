return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "markdownlint" },
        -- Conform will run the first available formatter
        css = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        vue = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      },
      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_format = "fallback",
      -- },
    })
  end,
}
