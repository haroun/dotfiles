.PHONY: default additional-apt additional-brew additional-vscode additional-vscode-save git gpg install javascript terminal update upgrade vim zsh
# .SILENT:

CURDIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGETDIR := $$HOME

default: install

additional-apt:
	@echo '>> apt'
	apt-get update && apt-get upgrade

additional-brew:
	@echo '>> homebrew'
	brew update && brew upgrade && brew upgrade --cask

additional-vscode:
	@echo '>> additional: vscode'
	@echo . 'Link settings.json & snippets'
	ln -fs "$(CURDIR)/additional/vscode/settings.json" "$(TARGETDIR)/.vscode/settings.json"
	ln -fs "$(CURDIR)/additional/vscode/snippets" "$(TARGETDIR)/.vscode/snippets"
	@echo . 'Install vscode packages from packages.list'
	@while IFS= read -r package; do code-insiders --install-extension "$$package" ; done < "$(CURDIR)/additional/vscode/packages.list"

additional-vscode-save:
	@echo '>> additional: vscode-save'
	@echo 'Save vscode installed packages in packages.list'
	code-insiders --list-extensions > "$(CURDIR)/additional/vscode/packages.list"

git:
	@echo '>> git'
	@echo 'Link .gitconfig, .gitconfig.user & .gitignore'
	ln -fs "$(CURDIR)/git/.gitconfig" "$(TARGETDIR)/.gitconfig"
	ln -fs "$(CURDIR)/git/.gitconfig.user" "$(TARGETDIR)/.gitconfig.user"
	ln -fs "$(CURDIR)/git/.gitignore" "$(TARGETDIR)/.gitignore"

gpg:
	@echo '>> gpg'
	@echo 'Link gpg-agent.conf'
	mkdir -p "$(TARGETDIR)/.gnupg"
	ln -fs "$(CURDIR)/gpg/gpg-agent.conf" "$(TARGETDIR)/.gnupg/gpg-agent.conf"
	find "$(TARGETDIR)/.gnupg" -type f -exec chmod 600 {} \;
	find "$(TARGETDIR)/.gnupg" -type d -exec chmod 700 {} \;

install:
	@echo '> install'
	make git
	make gpg
	make zsh
	make javascript
	make terminal
	make vim
	git submodule init && git submodule update && git submodule foreach "git checkout main || git checkout master"
	@echo 'Link .inputrc'
	ln -fs "$(CURDIR)/.inputrc" "$(TARGETDIR)/.inputrc"

javascript:
	@echo '>> javascript'
	@echo 'Install tern'
	npm install -g tern
	@echo 'Install npm-merge-driver'
	npm install -g npm-merge-driver
	@echo 'Link tern configuration'
	ln -fs "$(CURDIR)/javascript/.tern-config" "$(TARGETDIR)/.tern-config"

terminal:
	@echo '>> terminal'
	@echo 'Link alacritty'
	mkdir -p "$(TARGETDIR)/.config/alacritty"
	ln -fs "$(CURDIR)/terminal/alacritty/.alacritty.yml" "$(TARGETDIR)/.config/alacritty/alacritty.yml"
	@echo 'Link tmux'
	ln -fs "$(CURDIR)/terminal/tmux/tmux.conf" "$(TARGETDIR)/.tmux.conf"

update:
	@echo '>> update'
	git pull
	@echo 'npm'
	npm -g update
	@echo 'dependencies'
	git submodule update --init

upgrade:
	@echo '>> upgrade'
	git pull
	@echo 'npm'
	npm i -g npm
	@echo 'vim'
	pip3 install --user --upgrade pynvim
	cd $(CURDIR)/vim/pack/ternjs/start/tern_for_vim && npm install && cd $(CURDIR)
	@echo 'dependencies'
	git submodule foreach 'git checkout $$(git symbolic-ref --short HEAD) && git pull'
	npm outdated -g

vim:
	@echo '>> vim'
	@echo 'Link vim & nvim'
	ln -nfs "$(CURDIR)/vim" "$(TARGETDIR)/.vim"
	mkdir -p "$(TARGETDIR)/.config/nvim"
	ln -fs "$(CURDIR)/vim/init.vim" "$(TARGETDIR)/.config/nvim/init.vim"
	pip3 install --user --upgrade pynvim
	cd $(CURDIR)/vim/pack/ternjs/start/tern_for_vim && npm install && cd $(CURDIR)
	@echo 'Install vim language server protocol'
	npm install -g dockerfile-language-server-nodejs typescript typescript-language-server vscode-langservers-extracted
	@echo 'Install vim debug adapter protocol'
	cd $(CURDIR)/javascript/modules/microsoft/vscode-node-debug2 && npm ci && npx gulp build && cd $(CURDIR)
	@echo 'Install node.js provider'
	npm install -g neovim
	@echo 'Please open neovim and run :checkhealth & :UpdateRemotePlugins'

zsh:
	@echo '>> zsh'
	@echo 'Link .zshrc'
	ln -fs "$(CURDIR)/zsh/.zshenv" "$(TARGETDIR)/.zshenv"
	ln -fs "$(CURDIR)/zsh/.zshrc" "$(TARGETDIR)/.zshrc"
	ln -nfs "$(CURDIR)/zsh/modules" "$(TARGETDIR)/.zshmodules"
