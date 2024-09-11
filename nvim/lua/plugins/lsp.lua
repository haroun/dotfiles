return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        plugins = { "nvim-dap-ui" },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(
            mode,
            keys,
            func,
            { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc }
          )
        end
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Get signature help")
        map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders")
        map("n", "<space>D", vim.lsp.buf.type_definition, "Type definition")
        map("n", "<space>rn", vim.lsp.buf.rename, "Rename")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "<space>e", vim.diagnostic.open_float, "Diagnostic Open Float")
        map("n", "[d", vim.diagnostic.goto_prev, "Diagnostic Go to previous")
        map("n", "]d", vim.diagnostic.goto_next, "Diagnostic Go to next")
        map("n", "<space>q", vim.diagnostic.setloclist, "Diagnostic Set loc list")
      end

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      local servers = {
        css_variables = {},
        cssls = {},
        cssmodules_ls = {},
        cucumber_language_server = {},
        denols = {},
        diagnosticls = {},
        docker_compose_language_service = {},
        dockerls = {},
        elixirls = {},
        emmet_language_server = {},
        emmet_ls = {},
        eslint = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        markdown_oxide = {},
        vimls = {},
        volar = {},
        yamlls = {},
      }

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- DAP
        "elixirls",
        "node-debug2-adapter",

        -- linters
        "eslint_d",
        "markdownlint",
        "stylelint",
        "yamllint",
        "jsonlint",

        -- formatters
        "stylua", -- Used to format Lua code
        "prettier",
        "markdownlint",
      })
      -- A list of servers to automatically install if they're not already installed
      local registry = require("mason-registry")
      for _, pkg_name in ipairs(ensure_installed) do
        local ok, pkg = pcall(registry.get_package, pkg_name)
        if ok then
          if not pkg:is_installed() then
             pkg:install()
          end
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
