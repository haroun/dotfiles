.PHONY: atom atom-save git gpg install javascript php terminal update upgrade vim zsh
# .SILENT:

CURDIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGETDIR := $$HOME

atom:
	@echo '>> atom'
	@echo 'Link config.cson, init.coffee, keymap.cson, snippets.cson & styles.less'
	ln -fs "$(CURDIR)/atom/config.cson" "$(TARGETDIR)/.atom/config.cson"
	ln -fs "$(CURDIR)/atom/init.coffee" "$(TARGETDIR)/.atom/init.coffee"
	ln -fs "$(CURDIR)/atom/keymap.cson" "$(TARGETDIR)/.atom/keymap.cson"
	ln -fs "$(CURDIR)/atom/snippets.cson" "$(TARGETDIR)/.atom/snippets.cson"
	ln -fs "$(CURDIR)/atom/styles.less" "$(TARGETDIR)/.atom/styles.less"
	@echo 'Install atom packages from packages.list'
	apm-beta install --packages-file "$(CURDIR)/atom/packages.list"

atom-save:
	@echo '>> atom-save'
	@echo 'Save atom installed packages in packages.list'
	apm-beta list --installed --bare > "$(CURDIR)/atom/packages.list"

git:
	@echo '>> git'
	@echo 'Link .gitconfig, .gitconfig.user & .gitignore'
	ln -fs "$(CURDIR)/git/.gitconfig" "$(TARGETDIR)/.gitconfig"
	ln -fs "$(CURDIR)/git/.gitconfig.user" "$(TARGETDIR)/.gitconfig.user"
	ln -fs "$(CURDIR)/git/.gitignore" "$(TARGETDIR)/.gitignore"

gpg:
	@echo '>> gpg'
	@echo 'Link gpg-agent.conf'
	ln -fs "$(CURDIR)/gpg/gpg-agent.conf" "$(TARGETDIR)/.gnupg/gpg-agent.conf"

install:
	@echo '> install'
	make atom
	make git
	make gpg
	make zsh
	@echo 'Link .inputrc'
	ln -fs "$(CURDIR)/.inputrc" "$(TARGETDIR)/.inputrc"

javascript:
	@echo '>> javascript'
	@echo 'Link eslintrc configuration'
	ln -fs "$(CURDIR)/javascript/.eslintrc.json" "$(TARGETDIR)/.eslintrc.json"

php:
	@echo '> php'
	@echo 'Link composer.json/composer.lock & update dependencies'
	ln -fs "$(CURDIR)/php/composer.json" "$(TARGETDIR)/.composer/composer.json"
	ln -fs "$(CURDIR)/php/composer.lock" "$(TARGETDIR)/.composer/composer.lock"
	composer global update

terminal:
	@echo '>> terminal'
	@echo 'Link alacritty'
	ln -fs "$(CURDIR)/terminal/alacritty/.alacritty.yml" "$(TARGETDIR)/.alacritty.yml"
	@echo 'Link tmux'
	ln -fs "$(CURDIR)/terminal/tmux/tmux.conf" "$(TARGETDIR)/.tmux.conf"

update:
	@echo '>> update'
	git pull
	@echo 'homebrew'
	brew update
	@echo 'npm'
	npm -g update

upgrade:
	@echo '>> upgrade'
	git pull
	@echo 'homebrew'
	brew upgrade
	@echo 'npm'
	npm i -g npm

vim:
	@echo '>> vim'
	@echo 'Link vim & nvim'
	ln -fs "$(CURDIR)/vim" "$(TARGETDIR)/.vim"
	ln -fs "$(CURDIR)/vim/init.vim" "$(TARGETDIR)/.config/nvim/init.vim"

zsh:
	@echo '>> zsh'
	@echo 'Link .zshrc'
	ln -fs "$(CURDIR)/zsh/.zshenv" "$(TARGETDIR)/.zshenv"
	ln -fs "$(CURDIR)/zsh/.zshrc" "$(TARGETDIR)/.zshrc"
