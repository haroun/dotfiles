# README

## Install

* set [zsh][zsh] as default shell (i.e. `chsh -s $(which zsh)`)
* install [neovim][neovim] + python (2 & 3) + [pynvim][pynvim]
* install [tmux][tmux]
* install [gpg][gpg]
* install [nvm][nvm], [node][node] and [npm][npm]
* install [deno][deno]
* copy `git/.gitconfig.user.example` to `git/.gitconfig.user`
* install [docker][docker] + [docker compose][docker compose]
* install [ripgrep][ripgrep]
* install [fzf][fzf]
* install [bat][bat]
* install [zoxide][zoxide]
* install [mosh][mosh]
* install [bc][bc]
* install nerd fonts
* install [luarocks][luarocks]
* install [wget][wget]

## With GUI

* install [alacritty][alacritty]

```sh
# setup script
make install
```

## Update

```sh
# update repository & dependencies
make update
```

## Upgrade

```sh
# update repository & upgrade dependencies
make upgrade
```

## Other commands

```sh
# type make + [tab]
make
```

## Colorschemes

We use catpuccin-mocha

* [alacritty][catpuccin-alacritty]
* [bat][catpuccin-bat]

## Keyboard layout

`localectl --no-convert set-x11-keymap us pc104 altgr-intl`

## Known issues

### dircolors command not found on MacOS

Install coreutils using `brew install coreutils`

Be sure to read the command output for post install instructions.

## Links

* [git & gpg][github-gpg]
* [san francisco mono font][sf-mono-font] (if not available, please change the font in `terminal/alacritty/.alacritty.yml`)
* [neovim][neovim]
* [tmux][tmux]
* [nvm][nvm]
* [nodejs][node]
* [npm][npm]
* [deno][deno]
* [alacritty][alacritty]
* [zsh-autosuggestions][zsh-autosuggestions]
* [zsh-completions][zsh-completions]
* [zsh-history-substring-search][zsh-history-substring-search]
* [zsh-syntax-highlighting][zsh-syntax-highlighting]
* [ripgrep][ripgrep]
* [fzf][fzf]
* [bat][bat]
* [mosh][mosh]
* [zoxide][zoxide]
* optional [homebrew](https://brew.sh)

[zsh]: https://www.zsh.org
[neovim]: https://github.com/neovim/neovim
[pynvim]: https://github.com/neovim/pynvim
[tmux]: https://github.com/tmux/tmux
[gpg]: https://gnupg.org
[nvm]: https://github.com/nvm-sh/nvm
[node]: https://nodejs.org/en/
[npm]: https://www.npmjs.com
[deno]: https://deno.land
[alacritty]: https://github.com/jwilm/alacritty
[zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions
[zsh-completions]: https://github.com/zsh-users/zsh-completions
[zsh-history-substring-search]: https://github.com/zsh-users/zsh-history-substring-search
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[ripgrep]: https://github.com/BurntSushi/ripgrep
[fzf]: https://github.com/junegunn/fzf
[bat]: https://github.com/sharkdp/bat?tab=readme-ov-file#installation
[zoxide]: https://github.com/ajeetdsouza/zoxide
[mosh]: https://github.com/mobile-shell/mosh
[github-gpg]: https://help.github.com/categories/gpg/
[sf-mono-font]: https://developer.apple.com/fonts/
[docker]: https://www.docker.com/get-started
[docker compose]: https://docs.docker.com/compose/cli-command/
[bc]: https://www.gnu.org/software/bc/
[catpuccin-alacritty]: https://github.com/catppuccin/alacritty
[catpuccin-bat]: https://github.com/catppuccin/bat
[luarocks]: https://github.com/luarocks/luarocks
[wget]: https://www.gnu.org/software/wget/
