return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      text = { "markdownlint" },
      markdown = { "markdownlint" },
      javascript = { "eslint_d" },
      json = { "jsonlint" },
      css = { "stylelint" },
      scss = { "stylelint" },
      sass = { "stylelint" },
      less = { "stylelint" },
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>c?", function()
      local linters = require("lint").linters_by_ft[vim.bo.filetype] or {}
      if #linters == 0 then
        print("Linters: 󰦕")
        return
      end
      print("Linters: 󱉶 " .. table.concat(linters, ", "))
    end, { noremap = true, desc = "Get buffer existing linters" })
  end,
}
