-- diagnostics icons
-- Sort diagnostics by severity and display highest severity first
-- Highlight entire line for errors
-- Highlight the line number for warnings
-- vim.diagnostic.config({
--   severity_sort = true,
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = "*",
--       [vim.diagnostic.severity.WARN] = "!",
--       [vim.diagnostic.severity.INFO] = "&",
--       [vim.diagnostic.severity.HINT] = "?",
--     },
--     linehl = {
--       [vim.diagnostic.severity.ERROR] = "ErrorMsg",
--     },
--     numhl = {
--       [vim.diagnostic.severity.WARN] = "WarningMsg",
--     },
--   },
-- })
-- vim.fn.sign_define("DiagnosticSignError", { text = "*", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "&", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticSignHint" })

--- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

return {
  {
    "folke/trouble.nvim",
    opts = { -- for default options, refer to the configuration section for custom setup.
      auto_jump = false, -- auto jump to the item when there's only one
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "[x] Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "[X] Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "[S]ymbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "[L]SP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "[L]ocation List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "[Q]uickfix List (Trouble)",
      },
    },
  },
}
