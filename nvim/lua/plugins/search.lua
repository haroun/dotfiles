return {
  "junegunn/fzf.vim",
  dependencies = {
    { "junegunn/fzf", build = "./install --all" },
  },
  config = function()
    local function opts(desc)
      return { desc = desc, noremap = true, silent = true }
    end

    vim.keymap.set("n", "<leader><leader>", "<cmd>Buffers<CR>", opts("[ ] Search Buffers"))
    vim.keymap.set("n", "<leader>hb", "<cmd>BCommits<CR>", opts("Git [H]unk [B]uffer Commits"))
    vim.keymap.set("n", "<leader>hc", "<cmd>Commits<CR>", opts("Git [H]unk [C]ommits"))
    vim.keymap.set("n", "<leader>hs", "<cmd>GFiles?<CR>", opts("Git [H]unk [S]tatus"))
    vim.keymap.set("n", "<leader>s.", "<cmd>History<CR>", opts("[S]earch history [.]"))
    vim.keymap.set("n", "<leader>sc", "<cmd>Commands<CR>", opts("[S]earch [C]ommands"))
    vim.keymap.set("n", "<leader>sf", "<cmd>Files<CR>", opts("[S]earch [F]iles"))
    vim.keymap.set("n", "<leader>s<shift-f>", "<cmd>GFiles<CR>", opts("[S]earch Git [F]iles"))
    vim.keymap.set("n", "<leader>sg", "<cmd>Rg<CR>'", opts("[S]earch [G]rep"))
    vim.keymap.set("n", "<leader>sh", "<cmd>Helptags<CR>", opts("[S]earch [H]elp tags"))
    vim.keymap.set("n", "<leader>sm", "<cmd>Marks<CR>", opts("[S]earch [M]arks"))
    vim.keymap.set("n", "<leader>sn", "<cmd>Maps<CR>", opts("[S]earch [N]ormal mode mappings"))
  end,
}
