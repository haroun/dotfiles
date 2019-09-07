# README

## Install

* set [zsh][zsh] as default shell
* install [neovim][neovim] + [pynvim][pynvim]
* install [tmux][tmux]
* install [gpg][gpg]
* install [nvm][nvm], [node][node] and [npm][npm]

* install [homebrew](https://brew.sh)
* install [atom](https://atom.io/beta)
* install [vscode](https://code.visualstudio.com)
* install [docker](https://www.docker.com/get-started)
* copy `git/.gitconfig.user.example` to `git/.gitconfig.user`

```sh
# setup script
make install
```

```sh
# additional: mac only
# install node
brew install node

# install pure
npm install --global pure-prompt

# install gpg
brew install gpg

# install tmux
brew install tmux

# neovim
brew install neovim
brew install python
brew install python@2
pip2 install --user --upgrade pynvim
pip3 install --user --upgrade pynvim

# alacritty
brew cask install alacritty
```

## Update

```sh
# update repository & dependencies
make update
```

## Links

* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-completions](https://github.com/zsh-users/zsh-completions)
* [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [git & gpg](https://help.github.com/categories/gpg/)
* [san francisco mono font](https://developer.apple.com/fonts/)
* [neovim](https://github.com/neovim/neovim)
* [tmux][tmux]
* [nodejs][node]
* [npm][npm]
* [alacritty](https://github.com/jwilm/alacritty)
* optional [pure theme](https://github.com/sindresorhus/pure)
* optional [hyper-snazzy theme for terminal](https://github.com/sindresorhus/terminal-snazzy)
* optional [solarized theme for terminal](https://github.com/tomislav/osx-terminal.app-colors-solarized)

[zsh]: https://www.zsh.org
[neovim]: https://neovim.io
[pynvim]: https://github.com/neovim/pynvim
[tmux]: https://github.com/tmux/tmux
[gpg]: https://gnupg.org
[nvm]: https://github.com/nvm-sh/nvm
[node]: https://nodejs.org/en/
[npm]: https://www.npmjs.com
