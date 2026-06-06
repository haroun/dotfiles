vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable('astro')                  -- npm install -g @astrojs/language-server
vim.lsp.enable("denols")                 -- cf. https://github.com/denoland/deno#installation
vim.lsp.enable("diagnosticls")           -- npm install -g diagnostic-languageserver
vim.lsp.enable("docker_language_server") -- go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
vim.lsp.enable("elixirls")               -- cf. https://github.com/elixir-lsp/elixir-ls#building-and-running
vim.lsp.enable("eslint")                 -- npm install -g vscode-langservers-extracted
vim.lsp.enable("gitlab_ci_ls")           -- cargo install gitlab-ci-ls
vim.lsp.enable("html")                   -- npm install -g vscode-langservers-extracted
vim.lsp.enable("jsonls")                 -- npm install -g vscode-langservers-extracted
vim.lsp.enable("lua_ls")                 -- cf. https://luals.github.io/#neovim-install
vim.lsp.enable("markdown_oxide")         -- cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide
vim.lsp.enable("stylelint_lsp")          -- npm install -g @stylelint/language-server
vim.lsp.enable("svelte")                 -- npm install -g svelte-language-server
vim.lsp.enable("tailwindcss")            -- npm install -g @tailwindcss/language-server
vim.lsp.enable("terraformls")            -- cf. https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md
vim.lsp.enable("ts_ls")                  -- npm install -g typescript typescript-language-server
vim.lsp.enable("yamlls")                 -- npm install -g yaml-language-server

vim.lsp.config("elixirls", {
  cmd = { vim.fn.expand("~/.local/share/elixir-ls/language_server.sh") },
})

-- autocompletion
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method("textDocument/implementation") then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method("textDocument/completion") then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    -- if
    --   not client:supports_method("textDocument/willSaveWaitUntil")
    --   and client:supports_method("textDocument/formatting")
    -- then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
    --     buffer = ev.buf,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end
  end,
})

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode format local buffer" })
