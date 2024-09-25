return {
   "hrsh7th/nvim-cmp",
   event = { "InsertEnter", "CmdlineEnter" },
   -- Rest of your plugin spec
   dependencies = {
     "hrsh7th/cmp-nvim-lsp",
     "hrsh7th/cmp-path",
     "hrsh7th/cmp-buffer",
     "hrsh7th/cmp-nvim-lsp-document-symbol",
     "hrsh7th/cmp-nvim-lsp-signature-help",
     "hrsh7th/cmp-nvim-lua",
     "hrsh7th/cmp-cmdline",
     "hrsh7th/cmp-omni",
   },
   opts = function(_, opts)
     opts.sources = opts.sources or {}
     table.insert(opts.sources, {
       name = "lazydev",
       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
     })
   end,
   config = function()
     -- Set up nvim-cmp.
     local cmp = require("cmp")

     cmp.setup({
       snippet = {
         -- REQUIRED - you must specify a snippet engine
         expand = function(args)
           -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
           -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
           -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
           vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
         end,
       },
       window = {
         -- completion = cmp.config.window.bordered(),
         -- documentation = cmp.config.window.bordered(),
       },
       mapping = cmp.mapping.preset.insert({
         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-Space>"] = cmp.mapping.complete(),
         ["<C-e>"] = cmp.mapping.abort(),
         ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
       }),
       sources = cmp.config.sources({
         { name = "nvim_lsp" },
         { name = 'nvim_lsp_document_symbol' },
         { name = 'nvim_lsp_signature_help' },
         { name = "nvim_lua" },
         { name = 'path' },
         {
           name = 'cmdline',
           option = {
             ignore_cmds = { 'Man', '!' }
           }
         },
         {
           name = 'omni',
           option = {
             disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' }
           }
         },
         -- { name = "vsnip" }, -- For vsnip users.
         -- { name = 'luasnip' }, -- For luasnip users.
         -- { name = 'ultisnips' }, -- For ultisnips users.
         -- { name = 'snippy' }, -- For snippy users.
       }, {
         { name = "buffer" },
       }),
     })

     -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
     -- Set configuration for specific filetype.
     --[[ cmp.setup.filetype('gitcommit', {
     sources = cmp.config.sources({
       { name = 'git' },
     }, {
       { name = 'buffer' },
     })
  })
  require("cmp_git").setup() ]]
     --

     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline({ "/", "?" }, {
       mapping = cmp.mapping.preset.cmdline(),
       sources = {
         { name = "buffer" },
       },
     })

     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline(":", {
       mapping = cmp.mapping.preset.cmdline(),
       sources = cmp.config.sources({
         { name = "path" },
       }, {
         { name = "cmdline" },
       }),
       matching = { disallow_symbol_nonprefix_matching = false },
     })

     -- Set up lspconfig.
     -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
     -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
     -- require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
     --   capabilities = capabilities,
     -- })

     -- -- See `:help cmp`
     -- local cmp = require('cmp')
     -- local luasnip = require('luasnip')
     -- luasnip.config.setup {}
     --
     -- cmp.setup({
     --   snippet = {
     --     expand = function(args)
     --       luasnip.lsp_expand(args.body)
     --     end,
     --   },
     --   completion = { completeopt = 'menu,menuone,noinsert' },
     --
     --   -- For an understanding of why these mappings were
     --   -- chosen, you will need to read `:help ins-completion`
     --   --
     --   -- No, but seriously. Please read `:help ins-completion`, it is really good!
     --   mapping = cmp.mapping.preset.insert {
     --     -- Select the [n]ext item
     --     ['<C-n>'] = cmp.mapping.select_next_item(),
     --     -- Select the [p]revious item
     --     ['<C-p>'] = cmp.mapping.select_prev_item(),
     --
     --     -- Scroll the documentation window [b]ack / [f]orward
     --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
     --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
     --
     --     -- Accept ([y]es) the completion.
     --     --  This will auto-import if your LSP supports it.
     --     --  This will expand snippets if the LSP sent a snippet.
     --     ['<C-y>'] = cmp.mapping.confirm { select = true },
     --
     --     -- If you prefer more traditional completion keymaps,
     --     -- you can uncomment the following lines
     --     --['<CR>'] = cmp.mapping.confirm { select = true },
     --     --['<Tab>'] = cmp.mapping.select_next_item(),
     --     --['<S-Tab>'] = cmp.mapping.select_prev_item(),
     --
     --     -- Manually trigger a completion from nvim-cmp.
     --     --  Generally you don't need this, because nvim-cmp will display
     --     --  completions whenever it has completion options available.
     --     ['<C-Space>'] = cmp.mapping.complete {},
     --
     --     -- Think of <c-l> as moving to the right of your snippet expansion.
     --     --  So if you have a snippet that's like:
     --     --  function $name($args)
     --     --    $body
     --     --  end
     --     --
     --     -- <c-l> will move you to the right of each of the expansion locations.
     --     -- <c-h> is similar, except moving you backwards.
     --     ['<C-l>'] = cmp.mapping(function()
     --       if luasnip.expand_or_locally_jumpable() then
     --         luasnip.expand_or_jump()
     --       end
     --     end, { 'i', 's' }),
     --     ['<C-h>'] = cmp.mapping(function()
     --       if luasnip.locally_jumpable(-1) then
     --         luasnip.jump(-1)
     --       end
     --     end, { 'i', 's' }),
     --
     --     -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
     --     --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
     --   },
     --   sources = {
     --     {
     --       name = 'lazydev',
     --       -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
     --       group_index = 0,
     --     },
     --     { name = 'nvim_lsp' },
     --     { name = 'luasnip' },
     --     { name = 'path' },
     --   },
     -- })
   end,
}
