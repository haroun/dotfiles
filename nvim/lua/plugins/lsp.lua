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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
          -- Mappings.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            -- vim.keymap.set(mode, keys, func, { buffer = event.buf, noremap = true, silent = true, desc = "LSP: " .. desc })
          end

          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("<C-k>", vim.lsp.buf.signature_help, "Get signature help")
          map("<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
          map("<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
          map("<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")
          map("<space>D", vim.lsp.buf.type_definition, "Type definition")
          map("<space>rn", vim.lsp.buf.rename, "Rename")
          map("gr", vim.lsp.buf.references, "References")
          map("<space>e", vim.diagnostic.open_float, "Diagnostic Open Float")
          map("[d", vim.diagnostic.goto_prev, "Diagnostic Go to previous")
          map("]d", vim.diagnostic.goto_next, "Diagnostic Go to next")
          map("<space>q", vim.diagnostic.setloclist, "Diagnostic Set loc list")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local lspconfig = require("lspconfig")
      local servers = {
        css_variables = {},
        cssls = {},
        cssmodules_ls = {},
        cucumber_language_server = {},
        denols = {
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        },
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
        tailwindcss = {},
        ts_ls = {
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false
        },
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

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "v",
            package_pending = ">",
            package_uninstalled = "x",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers or {}),
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
