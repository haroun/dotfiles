# Neovim

## Elixir-ls

```sh
git clone https://github.com/elixir-lsp/elixir-ls.git
cd elixir-ls

mix deps.get
MIX_ENV=prod mix compile
MIX_ENV=prod mix elixir_ls.release2 -o ~/.local/share/elixir-ls
```
