.PHONY: additional-atom additional-atom-save additional-php additional-vscode git gpg install javascript terminal update upgrade vim zsh
# .SILENT:

CURDIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGETDIR := $$HOME

# TODO: homebrew references
# TODO: vscode target path
# TODO: install vscode packages from package.list

additional-atom:
	@echo '>> additional: atom'
	@echo 'Link config.cson, init.coffee, keymap.cson, snippets.cson & styles.less'
	ln -fs "$(CURDIR)/additional/atom/config.cson" "$(TARGETDIR)/.atom/config.cson"
	ln -fs "$(CURDIR)/additional/atom/init.coffee" "$(TARGETDIR)/.atom/init.coffee"
	ln -fs "$(CURDIR)/additional/atom/keymap.cson" "$(TARGETDIR)/.atom/keymap.cson"
	ln -fs "$(CURDIR)/additional/atom/snippets.cson" "$(TARGETDIR)/.atom/snippets.cson"
	ln -fs "$(CURDIR)/additional/atom/styles.less" "$(TARGETDIR)/.atom/styles.less"
	@echo 'Install atom packages from packages.list'
	apm-beta install --packages-file "$(CURDIR)/additional/atom/packages.list"

additional-atom-save:
	@echo '>> additional: atom-save'
	@echo 'Save atom installed packages in packages.list'
	apm-beta list --installed --bare > "$(CURDIR)/additional/atom/packages.list"

additional-php:
	@echo '>> additional: php'
	@echo 'Link composer.json/composer.lock & update dependencies'
	ln -fs "$(CURDIR)/additional/php/composer.json" "$(TARGETDIR)/.composer/composer.json"
	ln -fs "$(CURDIR)/additional/php/composer.lock" "$(TARGETDIR)/.composer/composer.lock"
	composer global update

additional-vscode:
	@echo '>> additional: vscode'
	@echo . 'Link settings.json & snippets'
	ln -fs "$(CURDIR)/additional/vscode/settings.json" "$(TARGETDIR)/Library/Application Support/Code - Insiders/User/settings.json"
	ln -fs "$(CURDIR)/additional/vscode/snippets" "$(TARGETDIR)/Library/Application Support/Code - Insiders/User/snippets"
	@echo . 'Save vscode installed packages in packages.list'
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
	ln -fs "$(CURDIR)/gpg/gpg-agent.conf" "$(TARGETDIR)/.gnupg/gpg-agent.conf"

install:
	@echo '> install'
	make git
	make gpg
	make javascript
	make terminal
	make vim
	make zsh
	git submodule init && git submodule update
	@echo 'Link .inputrc'
	ln -fs "$(CURDIR)/.inputrc" "$(TARGETDIR)/.inputrc"

javascript:
	@echo '>> javascript'
	@echo 'Link eslintrc configuration'
	ln -fs "$(CURDIR)/javascript/.eslintrc.json" "$(TARGETDIR)/.eslintrc.json"
	@echo 'Install tern'
	npm install -g tern
	@echo 'Link tern configuration'
	ln -fs "$(CURDIR)/javascript/.tern-config" "$(TARGETDIR)/.tern-config"
	@echo 'Please open neovim and run :checkhealth & :UpdateRemotePlugins'

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
	@echo 'homebrew'
	brew update
	@echo 'npm'
	npm -g update
	git submodule update --init

upgrade:
	@echo '>> upgrade'
	git pull
	@echo 'homebrew'
	brew upgrade
	@echo 'npm'
	npm i -g npm
	git submodule foreach 'git checkout master && git pull'

vim:
	@echo '>> vim'
	@echo 'Link vim & nvim'
	ln -fs "$(CURDIR)/vim" "$(TARGETDIR)/.vim"
	mkdir -p "$(TARGETDIR)/.config/nvim"
	ln -fs "$(CURDIR)/vim/init.vim" "$(TARGETDIR)/.config/nvim/init.vim"
	pip2 install --user --upgrade pynvim
	pip3 install --user --upgrade pynvim
	cd $(CURDIR)/vim/pack/ternjs/start/tern_for_vim && npm install && cd $(CURDIR)

zsh:
	@echo '>> zsh'
	@echo 'Link .zshrc'
	ln -fs "$(CURDIR)/zsh/.zshenv" "$(TARGETDIR)/.zshenv"
	ln -fs "$(CURDIR)/zsh/.zshrc" "$(TARGETDIR)/.zshrc"
	ln -fs "$(CURDIR)/zsh/modules" "$(TARGETDIR)/.zshmodules"
