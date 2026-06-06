-- TODO: remove comment
-- {
--   "L3MON4D3/LuaSnip",
--   version = "2.*",
--   build = (function()
--     -- Build Step is needed for regex support in snippets.
--     -- This step is not supported in many windows environments.
--     -- Remove the below condition to re-enable on windows.
--     if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--       return
--     end
--     return "make install_jsregexp"
--   end)(),
--   dependencies = {
--     -- `friendly-snippets` contains a variety of premade snippets.
--     --    See the README about individual language/framework/plugin snippets:
--     --    https://github.com/rafamadriz/friendly-snippets
--     -- {
--     --   "rafamadriz/friendly-snippets",
--     --   config = function()
--     --     require("luasnip.loaders.from_vscode").lazy_load()
--     --   end,
--     -- },
--   },
--   opts = {},
-- },

-- source: "L3MON4D3/LuaSnip"
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "LuaSnip"
        and (kind == "install" or kind == "update") then
      vim.system({ "make install_jsregexp" }, { cwd = ev.data.path })
    end
  end,
})

vim.pack.add({
  -- TODO: add version
  { src = "https://github.com/L3MON4D3/LuaSnip" }
})

local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
